class ServersController < ApplicationController
  before_action :security_private
  before_action :set_server, only: [:show, :destroy]

  helper_method :sort_column, :sort_direction

  def index
    @servers = @user.servers.order("#{sort_column} #{sort_direction}")
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

  def sortable_columns
    ["hostname", "uptime", "ram_usage", "disk_usage", "last_report"]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "hostname"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end