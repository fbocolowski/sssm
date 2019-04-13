class TriggersController < ApplicationController
  before_action :security_private
  before_action :set_server
  before_action :set_trigger, only: [:edit, :update, :destroy]

  def index
    @triggers = @server.triggers
  end

  def new
    @trigger = @server.triggers.new
  end

  def create
    @trigger = @server.triggers.new(trigger_params)
    if @trigger.validate
      if params[:create_for_all]
        @session.user.servers.each do |server|
          server.triggers.create(trigger_params)
        end
      else
        @trigger.save
      end
      redirect_to server_triggers_path(@server)
    else
      @alert = @trigger.errors.full_messages.first
      return render 'new'
    end
  end

  def edit

  end

  def update
    if @trigger.update(trigger_params)
      redirect_to server_triggers_path(@server)
    else
      @alert = @trigger.errors.full_messages.first
      return render 'edit'
    end
  end

  def destroy
    @trigger.destroy
    render json: {redirect: server_triggers_path(@server)}
  end

  private

  def set_server
    @server = @user.servers.find(params[:server_id])
  end

  def set_trigger
    @trigger = @server.triggers.find(params[:id])
  end

  def trigger_params
    params.require(:trigger).permit(:event, :criteria, :action, :url)
  end
end