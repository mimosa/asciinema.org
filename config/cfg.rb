module Asciinema
  class Configuration < ActiveInteraction::Base

    string :add_this_profile_id, :bugsnag_api_key, :aws_access_key_id, :aws_bucket, :aws_region, :aws_secret_access_key, :google_analytics_id
    string :carrierwave_storage,  default: 'file'
    string :carrierwave_storage_dir_prefix,  default: 'uploads/'
    integer :home_asciicast_id
    string :scheme,  default: 'http'
    string :host,  default: 'localhost:3000'
    string :scheme,  default: 'http'
    string :secret_token, default: '21deaa1a1228e119434aa783ecb4af21be7513ff1f5b8c1d8894241e5fc70ad395db72c8c1b0508a0ebb994ed88a8d73f6c84e44f7a4bc554a40d77f9844d2f4'
    array :admin_ids, default: [1, 2, 3, 4] do
      integer
    end
    hash :smtp_settings
    string :from_email, default: "Asciinema <hello@asciinema.org>"

    def home_asciicast
      asciicast = if home_asciicast_id
        Asciicast.find(home_asciicast_id)
      else
        Asciicast.last
      end
    end

    def ssl?
      scheme == 'https'
    end

  end
end

cfg_file = File.expand_path(File.dirname(__FILE__) + '/asciinema.yml')
cfg = YAML.load_file(cfg_file) || {} rescue {}
env = Hash[ENV.to_h.map { |k, v| [k.downcase, v] }]
cfg.merge!(env)

::CFG = Asciinema::Configuration.new(cfg)
