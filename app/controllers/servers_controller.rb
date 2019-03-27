class ServersController < ApplicationController
  before_action :security_private
  before_action :set_server, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @server = @user.servers.new
  end

  def create
    puts server_params
    puts params[:server][:hostname]
    @server = @user.servers.new(server_params)
    if @server.save
      return redirect_to server_path(@server)
    else
      @alert = @server.errors.full_messages.first
      return render 'new'
    end
  end

  def edit
  end

  def update
    if @server.update(server_params)
      return redirect_to server_path(@server)
    else
      @alert = @server.errors.full_messages.first
      return render 'edit'
    end
  end

  def destroy
    @server.destroy
    render json: {redirect: servers_path}
  end

  private

  def server_params
    params.require(:server).permit(:hostname)
  end

  def set_server
    @server = @user.servers.find(params[:id])
  end
end