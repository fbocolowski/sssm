class ChangePasswordController < ApplicationController
  before_action :security_private

  def update
    if sha1(params[:current_password]) == @user.password
      if params[:new_password] != "" && params[:new_password_again] != ""
        if params[:new_password] == params[:new_password_again]
          @user.update(password: params[:new_password])
          @alert = t(:password_changed)
        else
          @alert = t(:passwords_do_not_match)
        end
      else
        @alert = t(:new_password_cant_be_blank)
      end
    else
      @alert = t(:current_password_incorrect)
    end
    render 'account/show'
  end
end