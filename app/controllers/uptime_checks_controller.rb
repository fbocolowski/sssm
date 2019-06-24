class UptimeChecksController < ApplicationController
  before_action :security_private
  before_action :set_uptime_check, only: [:edit, :update, :destroy]

  def index
    @uptime_checks = UptimeCheck.all
  end

  def new
    @uptime_check = UptimeCheck.new
  end

  def create
    @uptime_check = UptimeCheck.new(uptime_check_params)
    if @uptime_check.save
      redirect_to uptime_checks_path
    else
      @alert = @uptime_check.errors.full_messages.first
      return render 'new'
    end
  end

  def edit

  end

  def update
    if @uptime_check.update(uptime_check_params)
      redirect_to uptime_checks_path
    else
      @alert = @uptime_check.errors.full_messages.first
      return render 'edit'
    end
  end

  def destroy
    @uptime_check.destroy
    render json: {redirect: uptime_checks_path}
  end

  private

  def set_uptime_check
    @uptime_check = UptimeCheck.find(params[:id])
  end

  def uptime_check_params
    params.require(:uptime_check).permit(:target, :action, :url)
  end
end