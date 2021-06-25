class RedisCache
  def self.new
    Redis.new(Rails.application.config_for(:redis)).flushdb if Rails.env == 'test'
    Redis.new(Rails.application.config_for(:redis))
  end
end
