require 'rufus-scheduler'

include TriggerNotificationSender

scheduler = Rufus::Scheduler.new

scheduler.cron '* * * * *' do
  Trigger.all.each do |trigger|
    case trigger.event
    when 'Server is down for N minutes'
      if !trigger.server.last_report_minutes.nil? && trigger.server.last_report_minutes > trigger.criteria
        TriggerNotificationSender.send(trigger)
      end
    when 'RAM usage above N%'
      if !trigger.server.ram_usage.nil? && trigger.server.ram_usage > trigger.criteria
        TriggerNotificationSender.send(trigger)
      end
    when 'Disk usage above N%'
      if !trigger.server.disk_usage.nil? && trigger.server.disk_usage > trigger.criteria
        TriggerNotificationSender.send(trigger)
      end
    end
  end
end

scheduler.cron '* * * * *' do
  # Delete every report older than 1 day
  Report.where(:created_at.lt => (Time.now.utc - 1.days)).delete_all
end