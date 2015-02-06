# -*- encoding: utf-8 -*-

# 配置文件上传系统
if defined? ::CarrierWave && Settings[:carrierwave]
  config = Settings.carrierwave
  ::CarrierWave.configure do |c|
    case config.storage
    when 'qiniu' # 七牛，云存储
      c.storage = :qiniu
      c.qiniu_access_key = config.access_key
      c.qiniu_secret_key = config.secret_key
      c.qiniu_bucket = config.bucket
      c.qiniu_bucket_domain = config.bucket_domain
    end
  end
end