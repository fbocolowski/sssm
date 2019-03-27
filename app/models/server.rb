class Server
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'servers'
  belongs_to :user
  has_many :reports

  field :nickname, type: String
  field :token, type: String

  before_create :generate_token

  validates :nickname, presence: true

  def last_active
    self.reports.last.created_at rescue "-"
  end

  def last_hostname
    self.reports.last.hostname rescue "-"
  end

  def last_distro
    self.reports.last.distro rescue "-"
  end

  def last_uptime
    begin
      t = self.reports.last.uptime
      mm, ss = t.divmod(60)
      hh, mm = mm.divmod(60)
      dd, hh = hh.divmod(24)
      return "%dd %dh %dm" % [dd, hh, mm]
    rescue
      "-"
    end
  end

  def last_ram
    begin
      pct = self.reports.last.ram_used * 100 / self.reports.last.ram_total
      return pct.round.to_s + "%"
    rescue
      "0%"
    end
  end

  def last_disk
    begin
      pct = self.reports.last.disk_used * 100 / self.reports.last.disk_total
      return pct.round.to_s + "%"
    rescue
      "0%"
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
