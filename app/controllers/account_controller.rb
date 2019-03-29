class AccountController < ApplicationController
  before_action :security_private

  def show
  end

  def create
    if @user.update(user_params)
      @alert = "Changes saved"
    else
      @alert = @user.errors.full_messages.first
    end
    return render 'show'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email)
  end
end