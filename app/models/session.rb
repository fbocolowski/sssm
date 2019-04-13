class Session
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'sessions'
  belongs_to :user

  field :token, type: String
  field :ip, type: String
  field :user_agent, type: String
  field :active, type: Boolean, default: true

  before_create :generate_token

  private

  def generate_token
    self.token = loop do
      random = SecureRandom.hex(13)
      break random if Server.where(token: random).count == 0
    end
  end
end
