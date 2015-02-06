module Api
  class BaseController < ApplicationController

    skip_before_action :verify_authenticity_token

    private

    def warden_strategies
      [:api_token]
    end

  end
end
