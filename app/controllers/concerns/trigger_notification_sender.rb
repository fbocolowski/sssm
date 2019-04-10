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

    def discord(url, content)
      if Rails.env.production?
        begin
          RestClient.post(url, {content: content}.to_json)
        rescue
          # do nothing
        end
      else
        puts 'DISCORD -> ' + url + ' / ' + content
      end
    end
  end
end