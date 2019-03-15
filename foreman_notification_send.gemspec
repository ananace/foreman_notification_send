require File.join File.expand_path('lib', __dir__), 'foreman_notification_send/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'foreman_notification_send'
  s.version     = ForemanNotificationSend::VERSION
  s.authors     = ['Alexander Olofsson']
  s.email       = ['alexander.olofsson@liu.se']
  # s.homepage    = 'TODO'
  s.summary     = 'summary'
  # s.description = 'TODO: Description of ForemanNotificationSend.'
  s.license     = 'MIT'

  s.files       = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'matrix_sdk', '~> 0.0.4'

  s.add_development_dependency 'bundler', '~> 1.16'
  s.add_development_dependency 'minitest', '~> 5.0'
  s.add_development_dependency 'rake', '~> 10.0'
end
