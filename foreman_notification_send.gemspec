# frozen_string_literal: true

require File.join File.expand_path('lib', __dir__), 'foreman_notification_send/version'

Gem::Specification.new do |s|
  s.name        = 'foreman_notification_send'
  s.version     = ForemanNotificationSend::VERSION
  s.authors     = ['Alexander Olofsson']
  s.email       = ['alexander.olofsson@liu.se']

  s.homepage    = 'https://github.com/ananace/foreman_notification_send'
  s.summary     = 'Send Foreman notifications to external systems'
  s.description = s.summary
  s.license     = 'GPL-3.0'

  s.files         = Dir['{app,config,db,lib}/**/*.{rake,rb}'] + %w[LICENSE.txt README.md]
  s.require_paths = ['lib']

  s.add_dependency 'matrix_sdk', '~> 2.6'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
end
