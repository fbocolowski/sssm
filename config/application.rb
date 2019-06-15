require_relative 'boot'

require "rails"
require "active_model/railtie"
require "action_controller/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module SSSM
  class Application < Rails::Application
    config.load_defaults 5.2

    config.generators.system_tests = nil

    config.time_zone = 'UTC'
  end
end
