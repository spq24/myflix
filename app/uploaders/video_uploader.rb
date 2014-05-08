class VideoUploader < CarrierWave::Uploader::Base

  def store_dir
    "uploads/movies/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
