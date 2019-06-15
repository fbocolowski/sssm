class TriggersController < ApplicationController
  before_action :security_private
  before_action :set_trigger, only: [:edit, :update, :destroy]

  def index
    @triggers = Trigger.all
  end

  def new
    @trigger = Trigger.new
  end

  def create
    @trigger = Trigger.new(trigger_params)
    if @trigger.save
      redirect_to triggers_path
    else
      @alert = @trigger.errors.full_messages.first
      return render 'new'
    end
  end

  def edit

  end

  def update
    if @trigger.update(trigger_params)
      redirect_to triggers_path
    else
      @alert = @trigger.errors.full_messages.first
      return render 'edit'
    end
  end

  def destroy
    @trigger.destroy
    render json: {redirect: triggers_path}
  end

  private

  def set_trigger
    @trigger = Trigger.find(params[:id])
  end

  def trigger_params
    params.require(:trigger).permit(:event, :criteria, :action, :url)
  end
end