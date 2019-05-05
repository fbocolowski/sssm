module NotificationSender
  class << self
    require 'rest-client'
    require 'json'

    def send_error(log_watcher, message)
      case log_watcher.action
      when 'Slack'
        slack(log_watcher.url, "Error found in #{log_watcher.name}", message)
      when 'Discord'
        discord(log_watcher.url, "Error found in #{log_watcher.name}", message)
      end
    end

    def send_trigger(trigger)
      last_notification = trigger.notifications.last
      if last_notification.nil? || ((Time.now - last_notification.created_at).to_i / 60) > 60
        trigger.notifications.create
        case trigger.action
        when 'Slack'
          slack(trigger.url, trigger.pretty_message, nil)
        when 'Discord'
          discord(trigger.url, trigger.pretty_message, nil)
        end
      end
    end

    def slack(url, text, attachment)
      begin
        RestClient.post(url, {payload: {text: text, attachments: [{text: attachment}]}.to_json})
      rescue
        # do nothing
      end
    end

    def discord(url, text, attachment)
      begin
        RestClient.post(url, {embeds: [{title: text, description: attachment}]}.to_json)
      rescue
        # do nothing
      end
    end
  end
end