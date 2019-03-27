Rails.application.configure do
  config.cache_classes = false
  config.eager_load = true

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.public_file_server.enabled = true

  config.active_support.deprecation = :log

  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true

  config.mongoid.logger.level = Logger::ERROR

  config.log_level = :debug
end
