class SessionsController < ApplicationController
  before_action :security_private
  before_action :set_session, only: [:destroy]

  def index
  end

  def destroy
    @session.update(active: false)
    render json: {redirect: sessions_path}
  end

  private

  def set_session
    @session = @user.sessions.find(params[:id])
  end
end