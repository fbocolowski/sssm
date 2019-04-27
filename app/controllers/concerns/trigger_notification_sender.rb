module TriggerNotificationSender
  class << self
    require 'rest-client'
    require 'json'

    def send(trigger)
      last_notification = trigger.notifications.last
      if last_notification.nil? || ((Time.now - last_notification.created_at).to_i / 60) > 60
        trigger.notifications.create
        case trigger.action
        when 'Slack'
          slack(trigger.url, trigger.pretty_message)
        when 'Discord'
          discord(trigger.url, trigger.pretty_message)
        end
      else
        puts 'Notification alredy sent in the last hour: ' + trigger.pretty_message
      end
    end

    def slack(url, text)
      if Rails.env.production?
        begin
          RestClient.post(url, {payload: {text: text}.to_json})
        rescue
          # do nothing
        end
      else
        puts 'Sending notification: ' + text
      end
    end

    def discord(url, content)
      if Rails.env.production?
        begin
          RestClient.post(url, {content: content}.to_json)
        rescue
          # do nothing
        end
      else
        puts 'Sending notification: ' + content
      end
    end
  end
end