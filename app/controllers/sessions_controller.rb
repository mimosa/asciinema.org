class SessionsController < ApplicationController
  include LoginHelper
  
  def create
    user = login_service.validate(params[:token].to_s.strip)

    if user
      self.current_user = user
      redirect_to_profile(user)
    else
      render :error
    end
  end

  def destroy
    self.current_user = nil
    redirect_to root_path, notice: "See you later!"
  end

  private

    def login_service
      EmailLoginService.new
    end

end
