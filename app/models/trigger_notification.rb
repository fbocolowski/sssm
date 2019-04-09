class TriggerNotification
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: 'trigger_notifications'
  belongs_to :trigger
end
