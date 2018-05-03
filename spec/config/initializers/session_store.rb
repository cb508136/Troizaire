# Be sure to restart your server when you modify this file.
Rails.application.config.session_store :redis_store, {
  servers: [
    {
      host: "localhost",
      port: 6379,
      db: 0,
      namespace: "session"
    },
  ],
  expire_after: 90.minutes,
  key: "_#{Rails.configuration.database_configuration[Rails.env]['database']}_session"
}

#Rails.application.config.session_store :cookie_store, key: '_nemo_session'
#Rails.application.config.session_store ActionDispatch::Session::CacheStore, cache: ActiveSupport::Cache::MemCacheStore.new('127.0.0.1:11211', { namespace: "#{Rails.configuration.database_configuration[Rails.env]['database']}_session", keepalive: true, key: "_#{Rails.configuration.database_configuration[Rails.env]['database']}_session", expire_after: 50.minutes }) #:dalli_store, :memcache_server => ['127.0.0.1:11211'], :namespace => "#{Rails.configuration.database_configuration[Rails.env]['database']}_session", :key => "_#{Rails.configuration.database_configuration[Rails.env]['database']}_session", :expire_after => 50.minutes
