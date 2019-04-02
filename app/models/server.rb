class Server
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'servers'
  belongs_to :user
  has_many :reports, dependent: :delete_all

  field :token, type: String

  before_create :generate_token

  def ip
    self.reports.last.ip rescue nil
  end

  def first_report
    self.reports.first.created_at rescue nil
  end

  def last_report
    self.reports.last.created_at rescue nil
  end

  def last_report_minutes
    begin
      (Time.now - self.reports.last.created_at).to_i / 60
    rescue
      nil
    end
  end

  def hostname
    self.reports.last.hostname rescue "Unknown"
  end

  def distro
    self.reports.last.distro rescue nil
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
      else
        "tux"
      end
    rescue
      "tux"
    end
  end

  def uptime
    begin
      t = self.reports.last.uptime
      mm, ss = t.divmod(60)
      hh, mm = mm.divmod(60)
      dd, hh = hh.divmod(24)
      return "%dd %dh %dm" % [dd, hh, mm]
    rescue
      nil
    end
  end

  def ram_usage
    begin
      pct = self.reports.last.ram_used * 100 / self.reports.last.ram_total
      return pct.round
    rescue
      0
    end
  end

  def disk_usage
    begin
      pct = self.reports.last.disk_used * 100 / self.reports.last.disk_total
      return pct.round
    rescue
      0
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
