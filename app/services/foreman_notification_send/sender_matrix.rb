# frozen_string_literal: true
require 'matrix_sdk/api'

module ForemanNotificationSend
  class SenderMatrix < SenderBase
    def send_notification(notification)
      client.send_message_event(room, 'm.room.message',
                                msgtype: 'm.notice',
                                body: notification.to_markdown,
                                formatted_body: notification.to_html,
                                format: 'org.matrix.custom.html')
    end

    private

    def client
      MatrixSdk::Api.new Setting[:notification_send_target_url], access_token: Setting[:notification_send_token]
    end

    def room
      @room ||= begin
        room = Setting[:notification_send_target_room]
        room = client.join_room(room).room_id if room.start_with? '#'
        room
      end
    end
  end
end
