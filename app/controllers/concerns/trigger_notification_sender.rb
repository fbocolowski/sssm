module TriggerNotificationSender
  class << self
    require 'rest-client'
    require 'json'

    def slack(url, text)
      if Rails.env.production?
        begin
          RestClient.post(url, {payload: {text: text}.to_json})
        rescue
          # do nothing
        end
      else
        puts 'SLACK -> ' + url + ' / ' + text
      end
    end

    def webhook(url, hostname, ip, message)
      if Rails.env.production?
        begin
          RestClient.post(url, {hostname: hostname, ip: ip, message: message}.to_json, {content_type: :json, accept: :json})
        rescue
          # do nothing
        end
      else
        puts 'WEBHOOK -> ' + url + ' / ' + hostname + ' / ' + ip + ' / ' + message
      end
    end
  end
end