Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = false

  config.active_support.deprecation = :log

  config.log_level = :debug

  config.mongoid.logger.level = Logger::ERROR
end
