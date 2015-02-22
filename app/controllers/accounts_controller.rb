require 'houston'
APN = Houston::Client.development

class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_account, only: [:show, :relay]

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to account_path(@account)
    end
  end

  def relay
    @body = request.body.string
    @json = JSON.parse(@body)
    @message = @json["message"]

    @account.devices.each do |device|
      APN.certificate = File.read("/Users/adambutler/Sites/pushitrealgood/public/cert.pem")
      notification = Houston::Notification.new(device: device.token)
      notification.alert = @message
      notification.badge = @json["badge"].to_i unless @json["badge"].nil?

      notification.sound = "alert.aiff"

      APN.push(notification)
    end

    render nothing: true, status: 200
  end

  private

  def account_params
    params.require(:account).permit(:key, :secret)
  end

  def set_account
    @account = Account.friendly.find_by_uid!(params[:id])
  end
end
