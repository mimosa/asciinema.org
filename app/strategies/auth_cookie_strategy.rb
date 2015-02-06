class AuthCookieStrategy < ::Warden::Strategies::Base

  def valid?
    access_token.present?
  end

  def authenticate!
    user = User.for_access_token(access_token)
    user && success!(user)
  end

  private

  def access_token
    request.cookies['access_token']
  end

end

Warden::Strategies.add(:auth_cookie, AuthCookieStrategy)
