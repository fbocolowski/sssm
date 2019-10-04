Rails.application.config.action_dispatch.cookies_serializer = :json

Rails.application.config.filter_parameters += [:password]

ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: [:json]
end

Mime::Type.register "text/x-script.sh", :sh

require 'rufus-scheduler'

include NotificationSender

scheduler = Rufus::Scheduler.singleton

return if defined?(Rails::Console) || Rails.env.test? || File.split($0).last == 'rake'

scheduler.cron '*/5 * * * *' do
  Trigger.all.each do |trigger|
    Server.all.each do |server|
      case trigger.event
      when 'Server is down for N minutes'
        if !server.last_report_minutes.nil? && server.last_report_minutes > trigger.criteria
          NotificationSender.send_trigger(trigger, server)
        end
      when 'RAM usage above N%'
        if !server.ram_usage.nil? && server.ram_usage > trigger.criteria
          NotificationSender.send_trigger(trigger, server)
        end
      when 'Disk usage above N%'
        if !server.disk_usage.nil? && server.disk_usage > trigger.criteria
          NotificationSender.send_trigger(trigger, server)
        end
      end
    end
  end
end

scheduler.cron '0 0 * * *' do
  Report.where(:created_at.lt => (Time.now - 3.days)).delete_all
end