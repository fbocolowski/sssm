class ChartsController < ApplicationController
  before_action :security_private
  before_action :set_server, only: [:show]

  def show
    case params[:time]
    when "1d"
      start_date = Date.today - 1.days
    when "1w"
      start_date = Date.today - 7.days
    when "1m"
      start_date = Date.today - 30.days
    when "1y"
      start_date = Date.today - 365.days
    end

    case params[:type]
    when "ram_usage"

      ram_total_data = Hash.new
      ram_used_data = Hash.new
      (start_date..Date.today).each do |day|
        reports = @server.reports.where(:created_at.gte => day.beginning_of_day, :created_at.lte => day.end_of_day)
        reports.each do |report|
          ram_total_data.store(report.created_at.strftime("%Y-%m-%d %H:%M:%S"), report.ram_total)
          ram_used_data.store(report.created_at.strftime("%Y-%m-%d %H:%M:%S"), report.ram_used)
        end
      end

      result = [{"name" => "RAM total", "data" => ram_total_data}, {"name" => "RAM used", "data" => ram_used_data}]

    when "disk_usage"

      disk_total_data = Hash.new
      disk_used_data = Hash.new
      (start_date..Date.today).each do |day|
        reports = @server.reports.where(:created_at.gte => day.beginning_of_day, :created_at.lte => day.end_of_day)
        reports.each do |report|
          disk_total_data.store(report.created_at.strftime("%Y-%m-%d %H:%M:%S"), report.disk_total)
          disk_used_data.store(report.created_at.strftime("%Y-%m-%d %H:%M:%S"), report.disk_used)
        end
      end

      result = [{"name" => "Disk total", "data" => disk_total_data}, {"name" => "Disk used", "data" => disk_used_data}]

    end

    render json: result
  end

  private

  def set_server
    @server = @user.servers.find(params[:server_id])
  end
end