require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Yam
  class Application < Rails::Application
    config.time_zone = 'Paris'
    config.i18n.default_locale = :fr
    config.active_record.schema_format = :sql
  end
end
