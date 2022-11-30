# frozen_string_literal: true

module ForemanNotificationSend
  module NotificationExtensions
    def self.prepended(base)
      base.class_eval do
        after_save :send_notification
      end
    end

    def send_notification
      send_notification_fallback if Setting[:notification_send_enable]

      # NotificationTarget.select { |target| target.should_send?(self) }
      #                   .each { |target| target.send(self) }
    rescue StandardError => e
      Foreman::Logging.exception "Failed to send notification #{self}", e
    end

    def level_to_symbol
      case notification_blueprint.level
      when 'success'
        '✅'
      when 'info'
        'ℹ️'
      when 'warning'
        '⚠️'
      else
        '❔'
      end
    end

    def to_html
      unless actions.empty?
        munged = (actions[:links] || []).map do |action|
          next unless action.key?(:href) && action.key?(:title)

          url = action[:href]
          url = Setting[:foreman_url] + url unless action[:external]

          "<a href=\"#{url}\">#{action[:title]}</a>"
        end
        action_str = "<br/>[ #{munged.join ' | '} ]"
      end

      "<b>#{notification_blueprint.group}</b>:<br/>#{level_to_symbol} #{message}#{action_str}"
    end

    def to_markdown
      unless actions.empty?
        munged = (actions[:links] || []).map do |action|
          next unless action.key?(:href) && action.key?(:title)

          url = action[:href]
          url = Setting[:foreman_url] + url unless action[:external]

          "[#{action[:title]}](#{url})"
        end
        action_str = "  \n\\[ #{munged.join ' | '}\\ ]"
      end
      "**#{notification_blueprint.group}**:\n#{level_to_symbol} #{message}#{action_str}"
    end

    private

    def send_notification_fallback
      SenderBase.create_sender(
        backend: :matrix,
        hs_url: Setting[:notification_send_target_url],
        access_token: Setting[:notification_send_token],
        room: Setting[:notification_send_target_room]
      ).send_notification(self)
    end
  end
end
