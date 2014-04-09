Myflix::Application.configure do

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { host: 'http://mfstage.herokuapp.com' }
  config.action_mailer.smtp_settings = {
  :port         => ENV['MAILGUN_SMTP_PORT'],
  :address        => ENV['MAILGUN_SMTP_SERVER'],
  :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
  :password       => ENV['MAILGUN_SMTP_PASSWORD'],
  :domain         => 'cryptic-forest-8895.herokuapp.com',
  :authentication       => 'plain' # Mandrill supports 'plain' or 'login'
  }
  ActionMailer::Base.delivery_method = :smtp

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
