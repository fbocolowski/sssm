require 'rufus-scheduler'
include TriggerNotificationSender

scheduler = Rufus::Scheduler.new

scheduler.cron '* * * * *' do
  @triggers = Trigger.all
  @triggers.each do |trigger|
    notify = false
    case trigger.event
    when "Server is down for N minutes"
      if !trigger.server.last_report_minutes.nil? && trigger.server.last_report_minutes > trigger.criteria
        notify = true
      end

    when "RAM usage above N%"
      if !trigger.server.ram_usage.nil? && trigger.server.ram_usage > trigger.criteria
        notify = true
      end

    when "Disk usage above N%"
      if !trigger.server.disk_usage.nil? && trigger.server.disk_usage > trigger.criteria
        notify = true
      end
    end

    if notify
      last_notification = trigger.notifications.last
      if last_notification.nil? || ((Time.now - last_notification.created_at).to_i / 60) > 60
        trigger.notifications.create
        case trigger.action
        when "Slack"
          TriggerNotificationSender.slack(trigger.url, trigger.pretty_message)
        when "Webhook"
          TriggerNotificationSender.webhook(trigger.url, trigger.server.hostname, trigger.server.ip, trigger.name)
        end
      end
    end
  end
end

scheduler.cron '* * * * *' do
  Report.where(:created_at.lt => (Time.now.utc - 1.days)).delete_all
end