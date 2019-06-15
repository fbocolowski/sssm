class ServersController < ApplicationController
  before_action :security_private
  before_action :set_server, only: [:show, :destroy]

  def index
    @servers = Server.order("hostname asc")
  end

  def show
  end

  def new
    @server = Server.create
    return redirect_to server_path(@server)
  end

  def destroy
    @server.destroy
    render json: {redirect: servers_path}
  end

  private

  def set_server
    @server = Server.find(params[:id])
  end
end