class LoginController < ApplicationController
  before_action :secutity_public

  def show
  end

  def create
    @found_user = User.where(username: params[:username], password: sha1(params[:password])).first rescue nil
    if @found_user.nil?
      @alert = 'Wrong username or password'
      return render 'show'
    else
      start_session(@found_user.id)
    end
  end
end