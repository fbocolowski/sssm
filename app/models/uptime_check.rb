class UptimeCheck
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'uptime_checks'

  field :target, type: String
  field :action, type: String
  field :url, type: String
  field :last_ok, type: Time
  field :last_notification, type: Time

  ACTIONS = ["Slack", "Discord"]

  validates :target, presence: true
  validates :action, presence: true, inclusion: {in: ACTIONS}
  validates :url, presence: true

  def last_ok_minutes
    begin
      (Time.now - self.last_ok).to_i / 60
    rescue
      nil
    end
  end
end
