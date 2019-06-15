class LogoutController < ApplicationController

  def show
    destroy_session
  end
end