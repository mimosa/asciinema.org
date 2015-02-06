# -*- encoding: utf-8 -*-

class LoginsController < ApplicationController
  force_ssl except: :sent

  def new
  end

  def create

    if login_service.login(login_params)
      redirect_to sent_login_path, flash: { email_recipient: params[:email] }
    else
      @invalid_email = true
      render :new
    end
  end

  def sent
    @email_recipient = flash[:email_recipient]
    redirect_to new_login_path unless @email_recipient
  end

  private

    def login_params
      params.require(:email)
    end

    def login_service
      EmailLoginService.new
    end

end
