class ChangePasswordController < ApplicationController
  before_action :security_private

  def show
  end

  def update
    if Digest::SHA1.hexdigest(params[:current_password]) == @user.password
      if params[:new_password] != "" && params[:new_password_again] != ""
        if params[:new_password] == params[:new_password_again]
          @user.update(password: params[:new_password])
          @alert = "Password changed"
        else
          @alert = "Password doesn't match"
        end
      else
        @alert = "Password can't be blank"
      end
    else
      @alert = "Wrong current password"
    end
    render 'show'
  end
end