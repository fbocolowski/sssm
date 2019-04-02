class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :load_session, :define_url

  private

  def sha1(string)
    Digest::SHA1.hexdigest(string)
  end

  def start_session(id)
    @session = User.find(id).sessions.create(ip: request.remote_ip, user_agent: request.user_agent)
    cookies[:session_id] = @session.token
    return redirect_to servers_path
  end

  def load_session
    if cookies[:session_id].present?
      @session = Session.where(token: cookies[:session_id], active: true).first rescue nil
      if @session.nil?
        destroy_session
      else
        @user = @session.user
      end
    else
      @session = nil
    end
  end

  def security_private
    destroy_session if @session.nil?
  end

  def security_public
    redirect_to servers_path unless @session.nil?
  end

  def destroy_session
    cookies[:session_id] = nil
    return redirect_to root_path
  end

  def define_url
    if Rails.env == 'production'
      @url = 'https://sssm.ml'
    else
      @url = 'http://localhost:3000'
    end
  end
end
