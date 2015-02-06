# -*- encoding: utf-8 -*-

class OmniauthCallbacksController < ApplicationController
  force_ssl
  include LoginHelper

  def authorize  
  end

  def callback
    user = User.for_oauth!(auth_hash, current_user)
    if user
      self.current_user = user
      redirect_to_profile(user)
    else
      render :error
    end
  end

  def failure
    redirect_to root_url(protocol: 'http'), alert: params[:error_description] || params[:error]
  end

  private

    def auth_hash
      request.env['omniauth.auth']
    end
end