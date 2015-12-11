# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  process :resize_to_limit => [700, 700]

  version :thumb do
    process :resize_to_limit => [150, 150]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
