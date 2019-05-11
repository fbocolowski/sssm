require 'rufus-scheduler'

include NotificationSender

scheduler = Rufus::Scheduler.new

scheduler.cron '* * * * *' do
  Trigger.all.each do |trigger|
    case trigger.event
    when 'Server is down for N minutes'
      if !trigger.server.last_report_minutes.nil? && trigger.server.last_report_minutes > trigger.criteria
        NotificationSender.send_trigger(trigger)
      end
    when 'RAM usage above N%'
      if !trigger.server.ram_usage.nil? && trigger.server.ram_usage > trigger.criteria
        NotificationSender.send_trigger(trigger)
      end
    when 'Disk usage above N%'
      if !trigger.server.disk_usage.nil? && trigger.server.disk_usage > trigger.criteria
        NotificationSender.send_trigger(trigger)
      end
    end
  end
end

scheduler.cron '* * * * *' do
end