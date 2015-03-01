require 'houston'
APN = Houston::Client.development

class AppsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_app, only: [:show, :relay]
  before_filter :set_apps, only: [:index]

  def new
    @app = App.new
  end

  def create
    @app = App.new(app_params)
    @app.user = current_user
    if @app.save
      redirect_to app_path(@app)
    end
  end

  private

  def app_params
    params.require(:app).permit(:key, :secret, :apn_certificate)
  end

  def set_app
    @app = current_user.apps.friendly.find_by_uid!(params[:id])
  end

  def set_apps
    @apps = current_user.apps
  end
end
