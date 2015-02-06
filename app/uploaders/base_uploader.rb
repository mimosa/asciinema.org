# encoding: utf-8

class BaseUploader < CarrierWave::Uploader::Base

  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    store_dir_prefix +
      "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def store_dir_prefix
    'uploads/'
  end

end