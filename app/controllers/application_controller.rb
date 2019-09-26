class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :load_session, :define_url

  private

  def start_session(id)
    cookies[:user_id] = id
    return redirect_to servers_path
  end

  def load_session
    if cookies[:user_id].present?
      @user = User.where(id: cookies[:user_id]).first rescue nil
      if @user.nil?
        destroy_session
      end
    else
      @user = nil
    end
  end

  def security_private
    destroy_session if @user.nil?
  end

  def security_public
    redirect_to servers_path unless @user.nil?
  end

  def destroy_session
    cookies[:user_id] = nil
    return redirect_to root_path
  end

  def define_url
    @url = "#{request.protocol}#{request.host_with_port}"
  end
end
