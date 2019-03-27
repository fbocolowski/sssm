Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = false

  config.active_support.deprecation = :log

  config.action_mailer.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true

  config.mongoid.logger.level = Logger::ERROR

  config.log_level = :error
  config.log_tags = [:request_id]
  config.log_formatter = ::Logger::Formatter.new
end
