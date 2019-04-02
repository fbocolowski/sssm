class DeleteAccountController < ApplicationController
  before_action :security_private

  def show
  end

  def create
    if sha1(params[:password_confirmation]) == @user.password
      @user.destroy
      destroy_session
    else
      @alert = 'Wrong password confirmation'
      render 'show'
    end
  end
end