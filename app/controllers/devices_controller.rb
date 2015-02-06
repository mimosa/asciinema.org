# -*- encoding: utf-8 -*-

class DevicesController < ApplicationController
  force_ssl
  before_action :ensure_authenticated!

  def create
    current_user.connect_device(params[:udid])
    redirect_to profile_path(current_user),
      notice: "Successfully registered your API token. "

  rescue ActiveRecord::RecordInvalid, Device::UDIDError
    render :error
  end

end
