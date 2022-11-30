# frozen_string_literal: true

require File.join File.expand_path('lib', __dir__), 'foreman_notification_send/version'

Gem::Specification.new do |spec|
  spec.name        = 'foreman_notification_send'
  spec.version     = ForemanNotificationSend::VERSION
  spec.authors     = ['Alexander Olofsson']
  spec.email       = ['alexander.olofsson@liu.se']

  spec.homepage    = 'https://github.com/ananace/foreman_notification_send'
  spec.summary     = 'Send Foreman notifications to external systems'
  spec.description = spec.summary
  spec.license     = 'GPL-3.0'

  spec.files       = Dir['{app,config,db,lib}/**/*.{rake,rb}'] + %w[LICENSE.txt README.md]

  spec.add_dependency 'matrix_sdk', '~> 2.6'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-minitest'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rails'
end
