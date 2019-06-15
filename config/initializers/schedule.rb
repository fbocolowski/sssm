require 'rufus-scheduler'

include NotificationSender

scheduler = Rufus::Scheduler.new

scheduler.cron '* * * * *' do
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

scheduler.cron '* * * * *' do
  Report.where(:created_at.lt => (Time.now - 1.days)).delete_all
end