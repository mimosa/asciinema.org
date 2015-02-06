module LoginHelper

  private

    def redirect_to_profile(user)
      if user.username
        redirect_back_or_to profile_path(user), notice: login_notice(user)
      else
        redirect_to new_username_url(protocol: 'http'), notice: login_notice(user)
      end
    end

    def login_notice(user)
      if user.first_login?
        "Welcome to asciinema!"
      else
        "Welcome back!"
      end
    end

end