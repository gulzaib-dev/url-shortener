# frozen_string_literal: true

# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins(*ENV['ALLOWED_CORS_ORIGINS'].split(','))
    resource '*', headers: :any, methods: [:get]
  end
end
