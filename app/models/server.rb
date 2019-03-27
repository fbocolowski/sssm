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

  def hostname
    self.reports.last.hostname rescue nil
  end

  def distro
    self.reports.last.distro rescue nil
  end

  def uptime
    self.reports.last.uptime rescue nil
  end

  def ram
    begin
      pct = self.reports.last.ram_used * 100 / self.reports.last.ram_total
      return pct.to_s + "%"
    rescue
      nil
    end
  end

  def disk
    begin
      pct = self.reports.last.disk_used * 100 / self.reports.last.disk_total
      return pct.to_s + "%"
    rescue
      nil
    end
  end

  private

  def generate_token
    self.token = loop do
      random = SecureRandom.urlsafe_base64(nil, false)
      break random if Server.where(token: random).count == 0
    end
  end
end
