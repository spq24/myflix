CarrierWave.configure do |config|
	if Rails.env.production? || Rails.env.development?
	    config.fog_credentials = {
	      :provider               => 'AWS',
	      :aws_access_key_id      => ENV['S3_KEY'],
	      :aws_secret_access_key  => ENV['S3_SECRET'],
	      :region                 => 'us-east-1'                        # required              # optional, defaults to 'us-east-1'
	    }
	    config.fog_directory   = ENV['S3_BUCKET_NAME'] # required
	    config.storage = :fog
	    config.cache_dir = 'carrierwave'
	    config.fog_public = false
	else
		config.storage = :file
		config.enable_processing = false
	end
end