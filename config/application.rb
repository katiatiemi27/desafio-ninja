require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Desafio
  class Application < Rails::Application
    config.load_defaults 7.0
    config.eager_load_paths << Rails.root.join('lib')
    
    config.i18n.default_locale = :'pt-BR'
    config.i18n.load_path += Dir[File.join(Rails.root, 'config', 'locales', '**', '*.{rb, yml}')]

    config.api_only = true
  end
end
