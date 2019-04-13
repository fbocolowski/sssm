class PasswordResetController < ApplicationController
  before_action :security_public

  def show
  end

  def create
    user = User.where(username: params[:username]).first rescue nil
    if !user.nil? && user.servers.where(token: params[:token]).present?
      if params[:new_password] == params[:confirm_password]
        user.update(password: params[:new_password])
        start_session(user.id) and return
      else
        @alert = t(:passwords_do_not_match)
      end
    else
      @alert = t(:username_token_not_found)
    end
    render 'show'
  end
end
