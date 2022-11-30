# frozen_string_literal: true

namespace :test do
  desc 'Test ForemanNotificationSend'
  Rake::TestTask.new(:foreman_notification_send) do |t|
    test_dir = File.join(__dir__, '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end

Rake::Task[:test].enhance %w[test:foreman_notification_send]
