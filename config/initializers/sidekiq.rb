# -*- encoding: utf-8 -*-

# 任务队列
if defined? ::Sidekiq
  #（动态）定时任务
  Sidekiq::Scheduler.dynamic = true
  redis_conn = proc { Settings.current_redis(:sidekiq) }
  # 服务端
  Sidekiq.configure_server do |c|
    c.redis = ConnectionPool.new(size: Sidekiq.options[:concurrency], &redis_conn)
    c.server_middleware do |chain|
      chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes # default
    end
    c.client_middleware do |chain|
      chain.add Sidekiq::Status::ClientMiddleware
    end
  end
  # 客户端
  Sidekiq.configure_client do |c|
    c.redis = ConnectionPool.new(size: 5, &redis_conn)
    c.client_middleware do |chain|
      chain.add Sidekiq::Status::ClientMiddleware
    end
  end

  if defined? ::Sidekiq::Monitor
    Sidekiq::Monitor.options[:poll_interval] = 5000
    Sidekiq::Monitor::Job.add_status('interrupted')
  end
end