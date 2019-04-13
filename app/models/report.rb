class Report
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'reports'
  belongs_to :server

  field :uptime, type: Float
  field :hostname, type: String
  field :distro, type: String
  field :ip, type: String
  field :ram_total, type: Float
  field :ram_used, type: Float
  field :disk_total, type: Float
  field :disk_used, type: Float

  field :token, type: String
  field :username, type: String

  after_create :update_server

  def update_server
    if self.server.first_report.nil?
      self.server.first_report = self.created_at
    end
    self.server.last_report = self.created_at
    self.server.ip = self.ip
    self.server.hostname = self.hostname
    self.server.distro = self.distro
    self.server.uptime = self.uptime
    self.server.ram_usage = begin
      (self.ram_used * 100 / self.ram_total).round
    rescue
      0
    end
    self.server.disk_usage = begin
      (self.disk_used * 100 / self.disk_total).round
    rescue
      0
    end
    self.server.save
  end
end
