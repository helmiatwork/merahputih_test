require "sidekiq/web"
require "sidekiq/middleware/i18n"

Sidekiq.configure_server do |config|
  config.redis = {url: Rails.application.credentials.dig(:redis_url, Rails.env)}
end

Sidekiq.configure_client do |config|
  config.redis = {url: Rails.application.credentials.dig(:redis_url, Rails.env)}
end

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add Sidekiq::Middleware::I18n::Client
  end
end

Sidekiq.configure_server do |config|
  config.client_middleware do |chain|
    chain.add Sidekiq::Middleware::I18n::Client
  end
  config.server_middleware do |chain|
    chain.add Sidekiq::Middleware::I18n::Server
  end
end
