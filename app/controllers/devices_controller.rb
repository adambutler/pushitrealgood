class DevicesController < ApplicationController

  before_filter :set_account, only: :create

  def create
    @device = Device.new(device_params)
    @device.account = @account
    if @device.save
      render json: @device
    end
  end

  private

  def device_params
    params.require(:device).permit(:token)
  end

  def set_account
    @account = Account.friendly.find_by_uid!(params[:account_id])
  end

end
