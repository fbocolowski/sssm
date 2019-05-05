class LogWatchersController < ApplicationController
  before_action :security_private
  before_action :set_server
  before_action :set_log_watcher, only: [:edit, :update, :destroy]

  def index
    @log_watchers = @server.log_watchers
  end

  def new
    @log_watcher = @server.log_watchers.new
  end

  def create
    @log_watcher = @server.log_watchers.new(log_watcher_params)
    if @log_watcher.save
      redirect_to edit_server_log_watcher_path(@server, @log_watcher)
    else
      @alert = @log_watcher.errors.full_messages.first
      return render 'new'
    end
  end

  def edit

  end

  def update
    if @log_watcher.update(log_watcher_params)
      redirect_to server_log_watchers_path(@server)
    else
      @alert = @log_watcher.errors.full_messages.first
      return render 'edit'
    end
  end

  def destroy
    @log_watcher.destroy
    render json: {redirect: server_log_watchers_path(@server)}
  end

  private

  def set_server
    @server = @user.servers.find(params[:server_id])
  end

  def set_log_watcher
    @log_watcher = @server.log_watchers.find(params[:id])
  end

  def log_watcher_params
    params.require(:log_watcher).permit(:name, :file, :action, :url)
  end
end