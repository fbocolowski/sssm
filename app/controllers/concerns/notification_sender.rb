module NotificationSender
  class << self
    require 'rest-client'
    require 'json'

    def send_error(log_watcher, message)
      case log_watcher.action
      when 'Slack'
        slack(log_watcher.url, "Errors found in #{log_watcher.name}", message)
      when 'Discord'
        discord(log_watcher.url, "Errors found in #{log_watcher.name}", message)
      end
    end

    def send_trigger(trigger, server)
      if server.last_notification.nil? || ((Time.now - server.last_notification).to_i / 60) > 60
        case trigger.action
        when 'Slack'
          slack(trigger.url, trigger.pretty_message(server.hostname, server.ip), nil)
        when 'Discord'
          discord(trigger.url, trigger.pretty_message(server.hostname, server.ip), nil)
        end
        server.update(last_notification: Time.now)
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
        puts "Slack: #{text}"
        puts "#{attachment}"
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
        puts "Discord: #{text}"
        puts "#{attachment}"
      end
    end
  end
end