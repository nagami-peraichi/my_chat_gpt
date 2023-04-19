#!/bin/bash
set -e

if [ "$RAILS_ENV" = "production" ]; then
  bin/rails db:migrate
fi

exec "$@"
