class Report
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'reports'
  belongs_to :server

  field :uptime, type: Float
  field :hostname, type: String
  field :distro, type: String
  field :ram_total, type: Float
  field :ram_used, type: Float
  field :disk_total, type: Float
  field :disk_used, type: Float
end
