Myflix::Application.configure do
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['S3_KEY'],                        # required
      :aws_secret_access_key  => ENV['S3_SECRET'],                        # required              # optional, defaults to 'us-east-1'
    }
    config.fog_directory   = ENV['S3_BUCKET_NAME'] # required
    config.fog_public = false
end

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { host: 'localhost:3000' }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.eager_load = false
end
