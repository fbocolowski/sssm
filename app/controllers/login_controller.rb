class LoginController < ApplicationController
  before_action :security_public

  def show
  end

  def create
    @found_user = User.where(username: params[:username], password: Digest::SHA1.hexdigest(params[:password])).first rescue nil
    if @found_user.nil?
      @alert = 'Wrong username or password'
      render 'show'
    else
      start_session(@found_user.id)
    end
  end
end
