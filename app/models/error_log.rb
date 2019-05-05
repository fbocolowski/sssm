class ErrorLog
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'error_logs'
  belongs_to :log_watcher

  field :filename, type: String
  field :line, type: String
  field :error, type: String

  validates :filename, presence: true
  validates :line, presence: true
  validates :error, presence: true
end
