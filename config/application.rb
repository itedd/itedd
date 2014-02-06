require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Itedd
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.secret_key_base = "7aad3dee5f40dbb365b8c440d8c23168ea3ad45bf3cb6da2b3c5a6ab3ed60d22870adf115d7486def34c90ca5b1b0618a19a86c1739887c15608fa6c24b74cdd"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.enforce_available_locales = true
    config.i18n.available_locales = [:en, :de]
    config.i18n.default_locale = :de
    config.i18n.fallbacks = [:en]
  end
end
