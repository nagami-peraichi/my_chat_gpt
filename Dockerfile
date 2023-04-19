ARG RUBY_VERSION=3.2.1
FROM ruby:$RUBY_VERSION-buster as base

ARG RAILS_ENV=production
ENV RAILS_ENV $RAILS_ENV
ENV RACK_ENV $RAILS_ENV
ENV BUNDLE_PATH $GEM_HOME
ENV RAILS_SERVE_STATIC_FILES=enabled
ENV RAILS_LOG_TO_STDOUT=enabled

ENV APP_DIR /rails
WORKDIR $APP_DIR

FROM base as builder
RUN set -ex && \
    apt-get update && \
    apt-get install -y \
      build-essential \
      git \
      libpq-dev \
      shared-mime-info \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*
COPY Gemfile* ./

RUN bundle config set --local without 'test development' && \
    bundle config set no-cache 'true' && \
    bundle config set force_ruby_platform true && \
    bundle install -j4 --retry 6 --no-cache

COPY . .

RUN bundle exec bootsnap precompile --gemfile app/ lib/
RUN SECRET_KEY_BASE=Dummy bundle exec rails assets:precompile

FROM base

RUN set -ex && \
    apt-get update && \
    apt-get install -y \
      build-essential \
      git \
      libpq-dev \
      shared-mime-info \
      ca-certificates

RUN useradd rails && chown -R rails:rails $APP_DIR
USER rails:rails

COPY --from=builder --chown=rails:rails $BUNDLE_PATH $BUNDLE_PATH
COPY --from=builder --chown=rails:rails $APP_DIR $APP_DIR
RUN mkdir -p log tmp/cache tmp/pids tmp/sockets && \
    chown -R rails:rails log tmp

EXPOSE 3000
ENTRYPOINT ["./entrypoint.sh"]
CMD ["./bin/rails", "server"]
