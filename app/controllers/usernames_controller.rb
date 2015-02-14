# -*- encoding: utf-8 -*-

class UsernamesController < ApplicationController
  force_ssl only: [:new, :create], except: :skip
  before_action :ensure_authenticated!

  def new
    @user = load_user
  end

  def create
    @user = load_user

    if @user.update(update_params)
      redirect_to_profile(@user)
    else
      @invalid_username = true
      render :new
    end
  end

  def skip
    redirect_to_profile(current_user)
  end

  private

    def load_user
      User.find(current_user.id)
    end

    def redirect_to_profile(user)
      redirect_back_or_to profile_path(user)
    end

    def update_params
      params.require(:user).permit(:username)
    end

end
