class Server
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'servers'
  has_many :reports, dependent: :delete_all

  field :token, type: String
  field :first_report, type: Time
  field :last_report, type: Time
  field :ip, type: String
  field :hostname, type: String
  field :distro, type: String
  field :uptime, type: Float
  field :ram_usage, type: Integer
  field :disk_usage, type: Integer
  field :last_notification, type: DateTime

  before_create :generate_token

  def last_report_minutes
    begin
      (Time.now - self.last_report).to_i / 60
    rescue
      nil
    end
  end

  def distro_logo
    begin
      if self.distro.include? "Fedora"
        "fedora"
      elsif self.distro.include? "Debian"
        "debian"
      elsif self.distro.include? "Ubuntu"
        "ubuntu"
      elsif self.distro.include? "Raspbian"
        "raspbian"
      elsif self.distro.include? "CentOS"
        "centos"
      elsif self.distro.include? "Manjaro"
        "manjaro"
      elsif self.distro.include? "Mint"
        "mint"
      elsif self.distro.include? "Antergos"
        "antergos"
      elsif self.distro.include? "Arch"
        "arch"
      end
    rescue
      # do nothing
    end
  end

  def uptime_string
    begin
      t = self.uptime
      mm, ss = t.divmod(60)
      hh, mm = mm.divmod(60)
      dd, hh = hh.divmod(24)
      return "%dd %dh %dm" % [dd, hh, mm]
    rescue
      nil
    end
  end

  private

  def generate_token
    self.token = loop do
      random = SecureRandom.hex(13)
      break random if Server.where(token: random).count == 0
    end
  end
end
