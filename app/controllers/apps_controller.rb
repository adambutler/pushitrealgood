require 'houston'
APN = Houston::Client.development

class AppsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_app, only: [:show, :relay]

  def new
    @app = App.new
  end

  def create
    @app = App.new(app_params)
    @app.apn_certificate = params[:app][:apn_certificate].read
    if @app.save
      redirect_to app_path(@app)
    end
  end

  def relay
    @body = request.body.string
    @json = JSON.parse(@body)
    @message = @json["message"]

    @app.devices.each do |device|
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

  def app_params
    params.require(:app).permit(:key, :secret)
  end

  def set_app
    @app = App.friendly.find_by_uid!(params[:id])
  end
end
