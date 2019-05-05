class Api::ReportsController < Api::ApplicationController
  def create
    server = Server.where(token: request.headers['SSSM-Token']).first rescue nil
    unless server.nil?
      report = server.reports.new(report_params)
      report.ip = request.remote_ip
      report.save
    end
    render json: ""
  end

  private

  def report_params
    params.require(:report).permit!
  end
end
