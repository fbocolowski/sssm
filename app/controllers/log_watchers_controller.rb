class LogWatchersController < ApplicationController
  before_action :security_private
  before_action :set_log_watcher, only: [:edit, :update, :destroy]

  def index
    @log_watchers = LogWatcher.all
  end

  def new
    @log_watcher = LogWatcher.new
  end

  def create
    @log_watcher = LogWatcher.new(log_watcher_params)
    if @log_watcher.save
      redirect_to edit_log_watcher_path(@log_watcher)
    else
      @alert = @log_watcher.errors.full_messages.first
      return render 'new'
    end
  end

  def edit

  end

  def update
    if @log_watcher.update(log_watcher_params)
      redirect_to log_watchers_path(@user)
    else
      @alert = @log_watcher.errors.full_messages.first
      return render 'edit'
    end
  end

  def destroy
    @log_watcher.destroy
    render json: {redirect: log_watchers_path}
  end

  private

  def set_log_watcher
    @log_watcher = LogWatcher.find(params[:id])
  end

  def log_watcher_params
    params.require(:log_watcher).permit(:name, :file, :action, :url)
  end
end