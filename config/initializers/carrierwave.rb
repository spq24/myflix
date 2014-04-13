CarrierWave.configure do |config|
	if Rails.env.production? || Rails.env.development?
	    config.aws_credentials = {
   		  access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    	  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
	    }
	    config.aws_bucket  = ENV['S3_BUCKET_NAME'] # required
	    config.storage = :aws

	else
		config.storage = :file
		config.enable_processing = false
	end
end