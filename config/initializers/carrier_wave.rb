CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['S3_KEY'],                        # required
      :aws_secret_access_key  => ENV['S3_SECRET'],                        # required
      :region                 => ENV['S3_REGION'],                  # optional, defaults to 'us-east-1'
    }
    config.fog_directory  = 'myflixq'                     # required
  else
    config.storage = :file
    config.enable_processing = false
  end
end