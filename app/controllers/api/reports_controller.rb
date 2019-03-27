class Api::ReportsController < Api::ApplicationController
  def create
    @server = Server.where(token: request.headers['Meeseeks-Token']).first rescue nil
    unless @server.nil?
      @server.reports.create(report_params)
    end
    render json: {}
  end

  private

  def report_params
    params.require(:report).permit!
  end
end
