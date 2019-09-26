class Api::ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :allow_cors

  private

  def allow_cors
    headers['Access-Control-Allow-Origin'] = '*'
  end
end