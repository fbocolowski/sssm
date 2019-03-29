class LogoutController < ApplicationController

  def show
    @session.update(active: false)
    destroy_session
  end
end