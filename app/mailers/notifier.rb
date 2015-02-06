# -*- encoding: utf-8 -*-

class Notifier < ActionMailer::Base

  def login_request(user_id, token)
    @user = User.find_by(id: user_id)
    @token = token
    mail to: @user.email
  end
  
end