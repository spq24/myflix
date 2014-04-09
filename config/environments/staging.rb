Myflix::Application.configure do

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { host: 'http://sleepy-ocean-5198.herokuapp.com/' }
  config.action_mailer.smtp_settings = {
  :port           => ENV['MAILGUN_SMTP_PORT'],
  :address        => ENV['MAILGUN_SMTP_SERVER'],
  :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
  :password       => ENV['MAILGUN_SMTP_PASSWORD'],
  :domain         => 'http://sleepy-ocean-5198.herokuapp.com/',
  :authentication       => 'plain' # Mandrill supports 'plain' or 'login'
  }
  ActionMailer::Base.delivery_method = :smtp

  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => ENV['S3_KEY'],                        # required
      :aws_secret_access_key  => ENV['S3_SECRET'],                        # required              # optional, defaults to 'us-east-1'
    }
    config.fog_directory   = ENV['S3_BUCKET_NAME'] # required
    config.fog_public = false
  end

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false

  config.assets.compress = true
  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify
end
