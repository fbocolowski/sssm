class TestLogWatcherController < ApplicationController
  before_action :security_private
  before_action :set_server
  before_action :set_log_watcher

  def show
    case @log_watcher.action
    when "Slack"
      NotificationSender.slack(@log_watcher.url, "Hi there! Your log watcher named #{@log_watcher.name} is working.", "Sample attachment")
    when "Discord"
      NotificationSender.discord(@log_watcher.url, "Hi there! Your log watcher named #{@log_watcher.name} is working.", "Sample attachment")
    end
    redirect_to server_log_watchers_path(@server)
  end

  private

  def set_server
    @server = @user.servers.find(params[:server_id])
  end

  def set_log_watcher
    @log_watcher = @server.log_watchers.find(params[:log_watcher_id])
  end
end