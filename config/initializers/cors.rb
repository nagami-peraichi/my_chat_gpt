Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ['http://localhost:3000', ENV['CORS_ORIGIN_URL']].compact
    resource '*', methods: :any, headers: :any
  end
end
