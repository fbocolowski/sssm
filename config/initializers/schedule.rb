# require 'rufus-scheduler'
#
# scheduler = Rufus::Scheduler.new
#
# scheduler.every '10s' do
#   start = (Date.today - 2.day).end_of_day
#   Server.where(:created_at.lte => start).each do |server|
#     puts server.hostname
#   end
# end