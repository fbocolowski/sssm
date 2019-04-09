class ServersController < ApplicationController
  before_action :security_private
  before_action :set_server, only: [:show, :destroy]

  def index
    @servers = @user.servers
  end

  def show
  end

  def new
    @server = @user.servers.create
    return redirect_to server_path(@server)
  end

  def destroy
    @server.destroy
    render json: {redirect: servers_path}
  end

  private

  def set_server
    @server = @user.servers.find(params[:id])
  end
end