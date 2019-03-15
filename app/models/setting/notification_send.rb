# frozen_string_literal: true

class Setting
  class NotificationSend < ::Setting
    def self.default_settings
      [
        set('notification_send_enable', _('Enable'), false, N_('Enable')),
        set('notification_send_target_url', _('Target URI'), 'https://matrix.org', N_('Target URI')),
        set('notification_send_target_room', _('Target Room'), '#test:matrix.org', N_('Target Room')),
        set('notification_send_token', _('Token'), 'abcdefg', N_('Token'))
      ]
    end

    def self.load_defaults
      # Check the table exists
      return unless super

      transaction do
        default_settings.each do |s|
          create! s.update(category: 'Setting::NotificationSend')
        end
      end

      true
    end

    def self.humanized_category
      N_('Notification Send')
    end
  end
end
