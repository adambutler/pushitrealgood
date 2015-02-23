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
    if @app.save
      redirect_to app_path(@app)
    end
  end

  private

  def app_params
    params.require(:app).permit(:key, :secret, :apn_certificate)
  end

  def set_app
    @app = App.friendly.find_by_uid!(params[:id])
  end
end
