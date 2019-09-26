Rails.application.configure do
  config.cache_classes = false
  config.eager_load = true

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.public_file_server.enabled = true

  config.active_support.deprecation = :log

  config.log_level = :debug

  config.mongoid.logger.level = Logger::ERROR
end
