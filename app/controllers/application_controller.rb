class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :load_session

  private

  def sha1(string)
    Digest::SHA1.hexdigest(string)
  end

  def start_session(id)
    puts 'Iniciando sessao ' + id
    cookies[:user] = id
    return redirect_to servers_path
  end

  def load_session
    if cookies[:user].present?
      @user = User.where(id: cookies[:user]).first rescue nil
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

  def secutity_public
    redirect_to servers_path unless @user.nil?
  end

  def destroy_session
    cookies[:user] = nil
    return redirect_to login_path
  end
end