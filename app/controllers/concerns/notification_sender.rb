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
      if trigger.last_notification.nil? || ((Time.now - trigger.last_notification).to_i / 60) > 60
        case trigger.action
        when 'Slack'
          slack(trigger.url, trigger.pretty_message, nil)
        when 'Discord'
          discord(trigger.url, trigger.pretty_message, nil)
        end
        trigger.update(last_notification: Time.now)
      end
    end

    def slack(url, text, attachment)
      if Rails.env.production?
        begin
          RestClient.post(url, {payload: {text: text, attachments: [{text: attachment}]}.to_json})
        rescue
          # do nothing
        end
      else
        puts "Slack: #{text} / #{attachment}"
      end
    end

    def discord(url, text, attachment)
      if Rails.env.production?
        begin
          RestClient.post(url, {embeds: [{title: text, description: attachment}]}.to_json)
        rescue
          # do nothing
        end
      else
        puts "Discord: #{text} / #{attachment}"
      end
    end
  end
end