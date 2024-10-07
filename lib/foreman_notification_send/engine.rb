# frozen_string_literal: true

module ForemanNotificationSend
  class Engine < ::Rails::Engine
    engine_name 'foreman_notification_send'

    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/services"]

    initializer 'foreman_notification_send.load_app_instance_data' do |app|
      ForemanNotificationSend::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    # rubocop:disable Metrics/BlockLength
    initializer 'foreman_notification_send.register_plugin', before: :finisher_hook do |app|
      app.reloader.to_prepare do
        Foreman::Plugin.register :foreman_notification_send do
          requires_foreman '>= 3.12'

          settings do
            category :notification_send, N_('Notification Send') do
              setting 'notification_send_enable',
                      type: :boolean,
                      description: N_('Enable'),
                      default: false,
                      full_name: N_('Enable')

              setting 'notification_send_target_url',
                      type: :string,
                      description: N_('Target URI'),
                      default: 'https://matrix.org',
                      full_name: N_('Target URI')

              setting 'notification_send_target_room',
                      type: :string,
                      description: N_('Target Room'),
                      default: '#test:matrix.org',
                      full_name: N_('Target Room')

              setting 'notification_send_token',
                      type: :string,
                      description: N_('Token'),
                      default: 'syt_abcdefg',
                      full_name: N_('Token')
            end
          end
        end
      end
    end
    # rubocop:enable Metrics/BlockLength

    config.to_prepare do
      Notification.prepend ForemanNotificationSend::NotificationExtensions
    rescue StandardError => e
      Rails.logger.fatal "foreman_notification_send: skipping engine hook (#{e})"
    end
  end
end
