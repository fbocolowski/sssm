class TestLogWatcherController < ApplicationController
  before_action :security_private
  before_action :set_log_watcher

  def show
    case @log_watcher.action
    when "Slack"
      NotificationSender.slack(@log_watcher.url, "Hi there! Your log watcher named #{@log_watcher.name} is working.", "Sample attachment")
    when "Discord"
      NotificationSender.discord(@log_watcher.url, "Hi there! Your log watcher named #{@log_watcher.name} is working.", "Sample attachment")
    end
    redirect_to log_watchers_path
  end

  private

  def set_log_watcher
    @log_watcher = @user.log_watchers.find(params[:log_watcher_id])
  end
end