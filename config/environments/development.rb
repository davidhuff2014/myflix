Myflix::Application.configure do
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false


  # must be turned on in either case
  config.action_mailer.default_url_options = { host: 'localhost:5000' }

  # Local system configuration
  config.action_mailer.delivery_method = :letter_opener
  # For sending emails comment out line above and uncomment this section
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #     address:              'smtp.computer-critters.com',
  #     port:                 587,
  #     domain:               'computer-critters.com',
  #     user_name:            ENV['SMTP_EMAIL'],
  #     password:             ENV['SMTP_PASSWORD'],
  #     authentication:       'login',
  #     enable_starttls_auto: true  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.eager_load = false

  config.action_dispatch.show_exceptions = false
end
