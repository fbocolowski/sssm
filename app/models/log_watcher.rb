class LogWatcher
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'log_watchers'
  has_many :error_logs, dependent: :delete_all

  field :token, type: String
  field :name, type: String
  field :file, type: String
  field :action, type: String
  field :url, type: String

  ACTIONS = ["Slack", "Discord"]

  validates :name, presence: true
  validates :file, presence: true
  validates :action, presence: true, inclusion: {in: ACTIONS}
  validates :url, presence: true

  before_create :generate_token

  private

  def generate_token
    self.token = loop do
      random = SecureRandom.hex(13)
      break random if LogWatcher.where(token: random).count == 0
    end
  end
end
