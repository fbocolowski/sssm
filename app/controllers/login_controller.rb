class LoginController < ApplicationController
  before_action :security_public

  def show
  end

  def create
    @found_user = User.where(username: params[:username], password: sha1(params[:password])).first rescue nil
    if @found_user.nil?
      @alert = 'Wrong username or password'
      render 'show'
    else
      start_session(@found_user.id)
    end
  end

  def recovery
  end

  def recover
    if params[:username] && params[:token] && params[:new_password] && params[:confirm_password]
      user = User.where(username: params[:username]).first rescue nil
      if user&.servers&.where(token: params[:token]).present?
        if params[:new_password] == params[:confirm_password]
          user.update(password: params[:new_password])
          start_session(user.id) and return
        else
          @alert = t(:passwords_do_not_match)
          render 'recovery' and return
        end
      end
    end
    @alert = t(:username_token_not_found)
    render 'recovery'
  end
end
