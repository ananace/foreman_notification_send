# frozen_string_literal: true

require 'test_plugin_helper'

class NotificationTest < ActiveSupport::TestCase
  let(:blueprint) { NotificationBlueprint.new group: 'test', level: 'info' }
  let(:notification) { Notification.new notification_blueprint: blueprint, message: 'example' }

  context 'Handling data manipulation' do
    test 'it should serialize to valid text' do
      assert_equal <<~MD.strip, notification.to_markdown
        **test**:
        ℹ️ example
      MD
      assert_equal <<~HTML.strip, notification.to_html
        <b>test</b>:<br/>ℹ️ example
      HTML
    end
  end
end
