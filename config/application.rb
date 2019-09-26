require_relative 'boot'

require "rails"
require "active_model/railtie"
require "action_controller/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module Application
  class Application < Rails::Application
    config.load_defaults 5.2

    config.generators.system_tests = nil

    config.i18n.available_locales = ['en-US']
    config.i18n.default_locale = 'en-US'

    config.time_zone = 'UTC'
  end
end