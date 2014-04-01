Myflix::Application.configure do

  config.action_mailer.delivery_method = :smtp  
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.smtp_settings = {
    :port                 => '587',
    :address              => "smtp.mandrillapp.com",
    :user_name            => ENV['MANDRILL_USERNAME'],
    :password             => ENV['MANDRILL_APIKEY'], # SMTP password is any valid API key
    :domain               => 'heroku.com', # your domain to identify your server when connecting
    :authentication       => :plain # Mandrill supports 'plain' or 'login'
  }

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
