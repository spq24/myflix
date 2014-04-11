class LargeCoverUploader < CarrierWave::Uploader::Base
   include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/public/tmp/monk_large.jpg"
  end

  process :resize_to_fit => [665, 375]

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
