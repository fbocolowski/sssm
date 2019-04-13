class Trigger
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'triggers'
  belongs_to :server
  has_many :notifications, class_name: 'TriggerNotification', dependent: :delete_all

  field :event, type: String
  field :criteria, type: Integer
  field :action, type: String
  field :url, type: String

  EVENTS = ["Server is down for N minutes", "RAM usage above N%", "Disk usage above N%"]
  ACTIONS = ["Slack", "Discord"]

  validates :event, presence: true, inclusion: {in: EVENTS}
  validates :criteria, presence: true, numericality: {greater_than_or_equal_to: 1}
  validates :action, presence: true, inclusion: {in: ACTIONS}
  validates :url, presence: true

  validates_uniqueness_of :server, scope: [:event, :criteria, :action, :url]

  def name
    self.event.gsub('N', self.criteria.to_s)
  end

  def pretty_message
    self.server.hostname + ' (' + self.server.ip + '): ' + self.name
  end
end
