# frozen_string_literal: true

module ForemanNotificationSend
  class Engine < ::Rails::Engine
    engine_name 'foreman_notification_send'

    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]

    initializer 'foreman_ipxe.load_default_settings', before: :load_config_initializers do
      require_dependency File.expand_path('../../app/models/setting/notification_send.rb', __dir__) if \
        begin
          Setting.table_exists?
        rescue StandardError
          (false)
        end
    end

    initializer 'foreman_notification_send.register_plugin', before: :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_notification_send do
        requires_foreman '>= 1.16'
      end
    end

    config.to_prepare do
      begin
        Notification.send(:prepend, ForemanNotificationSend::NotificationExtensions)
      rescue StandardError => e
        Rails.logger.fatal "foreman_notification_send: skipping engine hook (#{e})"
      end
    end
  end
end
