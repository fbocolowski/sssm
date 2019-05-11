class User
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'users'
  has_many :servers, dependent: :delete_all
  has_many :log_watchers, dependent: :delete_all
  has_many :sessions, dependent: :delete_all

  field :username, type: String
  field :password, type: String
  field :email, type: String

  before_create :encrypt_password
  before_update :encrypt_password
  before_validation :downcase_email

  validates :username, presence: true, format: {with: /\A[a-zA-Z0-9_.-]*\z/}, uniqueness: {case_sensitive: false}
  validates :password, presence: true
  validates :email, presence: false, allow_nil: true, allow_blank: true, uniqueness: {case_sensitive: false}, format: {with: URI::MailTo::EMAIL_REGEXP}

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def encrypt_password
    if self.password != nil && self.password != ""
      self.password = Digest::SHA1.hexdigest(password) if self.password_changed?
    end
  end
end
