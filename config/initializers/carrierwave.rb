CarrierWave.configure do |config|
	if Rails.env.production? || Rails.env.development?
	    config.fog_credentials = {
	      :provider               => 'AWS',
	      :aws_access_key_id      => ENV['aws_access_key_id'],
	      :aws_secret_access_key  => ENV['aws_secret_access_key']
	    }
	    config.fog_directory   = 'myflixq' # required
	    config.storage = :fog
	    config.fog_public = false
	    config.cache_dir = "#{Rails.root}/tmp/uploads/"
	else
		config.storage = :file
		config.enable_processing = false
	end
end