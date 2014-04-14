CarrierWave.configure do |config|
	if Rails.env.production? || Rails.env.development?
	    config.fog_credentials = {
	      :provider               => 'AWS',
	      :aws_access_key_id      => ENV['aws_access_key_id'],
	      :aws_secret_access_key  => ENV['aws_secret_access_key'],
	      :region                 => 'us-east-1'                        # required              # optional, defaults to 'us-east-1'
	    }
	    config.fog_directory   = ENV['S3_BUCKET_NAME'] # required
	    config.storage = :fog
	    config.fog_public = false
	    config.cache_dir = "#{Rails.root}/tmp/uploads"
	else
		config.storage = :file
		config.enable_processing = false
	end
end