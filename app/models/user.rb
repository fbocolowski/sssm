class User
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'users'

  field :username, type: String
  field :password, type: String

  before_create :encrypt_password
  before_update :encrypt_password

  validates :username, presence: true, format: {with: /\A[a-zA-Z0-9_.-]*\z/}, uniqueness: {case_sensitive: false}
  validates :password, presence: true

  private

  def encrypt_password
    if self.password != nil && self.password != ""
      self.password = Digest::SHA1.hexdigest(password) if self.password_changed?
    end
  end
end
