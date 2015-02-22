class DevicesController < ApplicationController

  before_filter :set_app, only: :create

  def create
    @device = Device.new(device_params)
    @device.app = @app
    if @device.save
      render json: @device
    end
  end

  private

  def device_params
    params.require(:device).permit(:token)
  end

  def set_app
    @app = App.friendly.find_by_uid!(params[:app_id])
  end

end
