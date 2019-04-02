class DestroyActiveSessionsController < ApplicationController
  before_action :security_private

  def destroy
    @user.sessions.each do |session|
      if @session != session
        session.active = false
        session.save
      end
    end
    render json: {redirect: sessions_path}
  end
end