# -*- encoding: utf-8 -*-

module ActionController
  module ForceNonSSL
    extend ActiveSupport::Concern
   
    module ClassMethods
      def force_ssl(options = {})
        super(options)
        force_non_ssl(options.except(:only)) if options.has_key?(:except)
      end

      def force_non_ssl(options = {})
        action_options = options.slice(*ACTION_OPTIONS)
        redirect_options = options.except(*ACTION_OPTIONS)
        before_filter(action_options) do
          force_non_ssl_redirect(redirect_options)
        end
      end
    end
   
    def force_non_ssl_redirect(host_or_options = nil)
      if request.ssl?
        options = {
          protocol: 'http://',
          host: request.host,
          path: request.fullpath,
          status: :moved_permanently
        }
   
        if host_or_options.is_a?(Hash)
          options.merge!(host_or_options)
        elsif host_or_options
          options.merge!(host: host_or_options)
        end
   
        non_secure_url = ActionDispatch::Http::URL.url_for(options.slice(*URL_OPTIONS))
        flash.keep if respond_to?(:flash)
        redirect_to non_secure_url, options.slice(*REDIRECT_OPTIONS)
      end
    end
   
  end
end

ActionController::ForceSSL.send :include, ActionController::ForceNonSSL
puts '_'*88