class RedisCache
  def self.new
    Redis.new(Rails.application.config_for(:redis)).flushdb if Rails.env == 'test'
    Redis.new(Rails.application
      .config_for(:redis)
      .merge({ ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE } }))
  end
end
