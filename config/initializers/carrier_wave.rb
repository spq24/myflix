CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['S3_KEY'],                        # required
      :aws_secret_access_key  => ENV['S3_SECRET'],                        # required
      :region                 => ENV['S3_REGION'],                  # optional, defaults to 'us-east-1'
    }
    config.fog_directory    = ENV['S3_BUCKET_NAME'] # required

    if Rails.env.test? || Rails.env.development?                      
      config.storage = :file
      config.enable_processing = false
    else
        config.storage = :fog
    end
end