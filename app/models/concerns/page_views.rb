module PageViews
  def initialize_pagevew
    Myapp::Redis.new.set self.redis_key, 0
  end

  def pageview
    Myapp::Redis.new.get self.redis_key
  end

  def increase_pageview!
    count = Myapp::Redis.new.get(self.redis_key).present? ?
      Myapp::Redis.new.get(self.redis_key).next : 1
    Myapp::Redis.new.set self.redis_key, count
  end

  def destroy_pageview!
    Myapp::Redis.new.del self.redis_key
  end
end
