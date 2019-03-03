if Rails.env.production?
  port = ENV['REDIS_PORT']
  host = ENV['REDIS_HOST']
  key = ENV['REDIS_KEY']

  sidekiq_config = { host: host, port: port, password: key, ssl: true }
else
  sidekiq_config = { url: ENV['REDIS_URL'] }
end

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
