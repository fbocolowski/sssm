class ChartsController < ApplicationController
  before_action :security_private
  before_action :set_server, only: [:show]

  def show
    case params[:type]
    when "ram_usage"
      ram_total_data = Hash.new
      ram_used_data = Hash.new
      reports = @server.reports.where(:created_at.gte => Time.now.utc - 24.hours)
      reports.each do |report|
        ram_total_data.store(report.created_at.strftime("%Y-%m-%d %H:%M:%S"), report.ram_total)
        ram_used_data.store(report.created_at.strftime("%Y-%m-%d %H:%M:%S"), report.ram_used)
      end
      result = [{"name" => "RAM total", "data" => ram_total_data}, {"name" => "RAM used", "data" => ram_used_data}]
    when "disk_usage"
      disk_total_data = Hash.new
      disk_used_data = Hash.new
      reports = @server.reports.where(:created_at.gte => Time.now.utc - 24.hours)
      reports.each do |report|
        disk_total_data.store(report.created_at.strftime("%Y-%m-%d %H:%M:%S"), report.disk_total)
        disk_used_data.store(report.created_at.strftime("%Y-%m-%d %H:%M:%S"), report.disk_used)
      end
      result = [{"name" => "Disk total", "data" => disk_total_data}, {"name" => "Disk used", "data" => disk_used_data}]
    end

    render json: result
  end

  private

  def set_server
    @server = Server.find(params[:server_id])
  end
end