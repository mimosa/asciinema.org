# -*- encoding: utf-8 -*-

class PhotoUploader < CarrierWave::Uploader::Base
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    store_url + "/#{version_name}.jpg"
  end

  def qiniu_async_ops
    commands = []
    # 按坐标裁剪
    if self.model.respond_to?(:crop_x) && self.model.crop_x.present?
      commands << "#{qiniu_file_url}?imageMogr/v2/crop/!#{self.model.crop_w}x#{self.model.crop_h}a#{self.model.crop_x}a#{self.model.crop_y}"
    end
    # 按版本裁剪
    unless version_names.empty?
      version_names.each do |version|
        commands << "#{qiniu_file_url}_#{version}"
      end
    end
    commands
  end

  # 默认版本
  def version_names
    %w(1280 720)
  end

  # Override url method to implement with "Image Space"
  def url(version_name = '', opts={})
    delimiter = opts.delete(:delimiter) || '_'
    stamp = opts.delete(:stamp) || false

    current_url ||= super(opts).gsub('%2F', '/')
    if current_url.present?
      version_name = version_name.to_s
      if version_name.present? && version_name.in?(version_names)
        current_url = [current_url, version_name].join(delimiter)
      end
      current_url += "?#{model.updated_at.to_i}" if stamp && model.respond_to?(:updated_at)
    end
    return current_url || default_url
  end
  
  # Override the filename of the uploaded files:
  def filename
    if super.present?
      @name ||= model.try(:id) || Digest::MD5.hexdigest(current_path)
      "#{Time.now.year}/#{@name}.#{file.extension.downcase}"
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  private
    def qiniu_file_url
      qiniu_store_url + "/#{self.filename}"
    end

    # 七牛的 URL
    def qiniu_store_url
      qiniu_url + "/#{self.store_dir}"
    end

    # 七牛的 根URL
    def qiniu_url
      "http://#{self.qiniu_bucket_domain}"
    end

end