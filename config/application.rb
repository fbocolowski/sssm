require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module Meeseeks
  class Application < Rails::Application
    config.load_defaults 5.2

    config.generators.system_tests = nil
  end
end
