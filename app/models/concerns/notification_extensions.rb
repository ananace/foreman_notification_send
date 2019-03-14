# frozen_string_literal: true

module ForemanNotificationSend
  module NotificationExtensions
    def self.prepended(base)
      base.class_eval do
        after_save :send_notification
      end
    end

    def send_notification
      puts to_markdown
      puts to_html
    end

    def to_html
      if actions
        action_str = ''

        (actions[:links] || []).each do |action|
          next unless action.key?(:href) && action.key?(:title)

          action_str += ' | ' unless action_str.empty?
          action_str += "<a href=\"#{action[:href]}\">#{action[:title]}</a>"
        end
        action_str = "<br/>[#{action_str}]"
      end
      "<b>#{notification_blueprint.group}</b>: #{message}#{action_str}"
    end

    def to_markdown
      if actions
        action_str = ''

        (actions[:links] || []).each do |action|
          next unless action.key?(:href) && action.key?(:title)

          action_str += ' | ' unless action_str.empty?
          action_str += "[#{action[:title]}](#{action[:href]})"
        end
        action_str = "  \n[#{action_str}]"
      end
      "**#{notification_blueprint.group}**: #{message}#{action_str}"
    end
  end
end
