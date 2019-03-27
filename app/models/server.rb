class Server
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'servers'
  belongs_to :user
  has_many :reports

  field :hostname, type: String
  field :token, type: String

  before_create :generate_token

  validates :hostname, presence: true

  def last_active
    self.reports.last.created_at rescue nil
  end

  private

  def generate_token
    self.token = loop do
      random = SecureRandom.urlsafe_base64(nil, false)
      break random if Server.where(token: random).count == 0
    end
  end
end
