# -*- encoding: utf-8 -*-
# Be sure to restart your server when you modify this file.
Rails.application.configure do
  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.0'

  config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'fontawesome', 'fonts')
  config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'bootstrap-sass-official', 'assets', 'fonts')

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  config.assets.precompile += %w( player.css player.js embed.css embed.js widget.js )
  config.assets.precompile << /.*.(?:eot|svg|ttf|woff|woff2)$/
  # I18n
  config.assets.initialize_on_precompile = true
end