# frozen_string_literal: true
module ForemanNotificationSend
  module NotificationExtensions
    def self.prepended(base)
      base.class_eval do
        after_save :send_notification
      end
    end

    def send_notification
      if Setting[:notification_send_enable]
        sender = SenderBase.create_sender(
          backend: :matrix,
          hs_url: Setting[:notification_send_target_url],
          access_token: Setting[:notification_send_token],
          room: Setting[:notification_send_target_room]
        )
        sender.send_notification(self)
      end

      #NotificationTarget.select { |target| target.should_send?(self) }
      #                  .each { |target| target.send(self) }
    rescue StandardError => ex
      Foreman::Logging.exception "Failed to send notification #{self}", ex
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
        action_str = ''

        (actions[:links] || []).each do |action|
          next unless action.key?(:href) && action.key?(:title)

          url = action[:href]
          url = Setting[:foreman_url] + url unless action[:external]

          action_str += ' | ' unless action_str.empty?
          action_str += "<a href=\"#{url}\">#{action[:title]}</a>"
        end
        action_str = "<br/>[ #{action_str} ]"
      end

      "<b>#{notification_blueprint.group}</b>:<br/>#{level_to_symbol} #{message}#{action_str}"
    end

    def to_markdown
      unless actions.empty?
        action_str = ''

        (actions[:links] || []).each do |action|
          next unless action.key?(:href) && action.key?(:title)

          url = action[:href]
          url = Setting[:foreman_url] + url unless action[:external]

          action_str += ' | ' unless action_str.empty?
          action_str += "[#{action[:title]}](#{url})"
        end
        action_str = "  \n\\[ #{action_str}\\ ]"
      end
      "**#{notification_blueprint.group}**:\n#{level_to_symbol} #{message}#{action_str}"
    end
  end
end
