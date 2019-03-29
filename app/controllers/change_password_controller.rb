class ChangePasswordController < ApplicationController
  before_action :security_private

  def update
    if sha1(params[:current_password]) == @user.password
      if params[:new_password] != "" && params[:new_password_again] != ""
        if params[:new_password] == params[:new_password_again]
          @user.update(password: params[:new_password])
          @alert = 'Password changed'
        else
          @alert = "New password does't match"
        end
      else
        @alert = "New password can't be blank"
      end
    else
      @alert = "Current password is incorrect"
    end
    render 'account/show'
  end
end