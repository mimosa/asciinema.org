# -*- encoding: utf-8 -*-

# Usage:
# In your (Application)Controller:
#   include Concerns::ForceNonSSL
#   force_non_ssl
#
# You can use the same options as with force_ssl.
# See: http://api.rubyonrails.org/classes/ActionController/ForceSSL/ClassMethods.html#method-i-force_ssl
#
# Code based on: https://github.com/rails/rails/blob/ab08519b1aed46dbd4b3e13932bbaddfe42d8315/actionpack/lib/action_controller/metal/force_ssl.rb
#
require 'active_support/concern'
module Concerns::ForceNonSSL
 
  extend ActiveSupport::Concern

  ACTION_OPTIONS = [:only, :except, :if, :unless]
  URL_OPTIONS = [:protocol, :host, :domain, :subdomain, :port, :path]
  REDIRECT_OPTIONS = [:status, :flash, :alert, :notice]

  module ClassMethods
    def force_ssl(options = {})
      super(options)
      # 有异己     
      if options.has_key?(:except)
        options[:only] = options.delete(:except) 
      elsif options.has_key?(:only)
        options[:except] = options.delete(:only) 
      end
      force_non_ssl(options) if options.has_key?(:except) || options.has_key?(:only)
    end

    def force_non_ssl(options = {})
      action_options = options.slice(*ACTION_OPTIONS)
      redirect_options = options.except(*ACTION_OPTIONS)
      before_action(action_options) do
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
    else

    end
  end

end