class RegistrationController < ApplicationController
  before_action :secutity_public

  def show
    @new_user = User.new
  end

  def create
    @new_user = User.new(user_params)
    if @new_user.save
      start_session(@new_user.id)
    else
      @alert = @new_user.errors.full_messages.first
      return render 'show'
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end
end