class NotificationsController < ApplicationController
  before_action :security_private

  def index
    @notifications = Set[]
    @user.servers.each do |server|
      server.triggers.each do |trigger|
        unless trigger.notifications.empty?
          notification = trigger.notifications.last
          @notifications.add({
                                 'server_id' => server.id.to_s,
                                 'hostname' => server.hostname,
                                 'event' => trigger.name,
                                 'date' => notification.created_at.strftime("%Y-%m-%d %H:%M:%S")
                             })
        end
      end
    end
  end
end