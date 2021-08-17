# frozen_string_literal: true
require 'matrix_sdk/api'

module ForemanNotificationSend
  class SenderMatrix < SenderBase
    def initialize(hs_url:, access_token:, room:, msgtype: 'm.notice')
      room = MatrixSdk::MXID.new room unless room.is_a?(MatrixSdk::MXID) 
      raise ArgumentError, 'room must be a Matrix room ID/Alias' unless room.room?

      @hs_url = hs_url
      @access_token = access_token
      @room = room
      @msgtype = msgtype
    end

    def send_notification(notification)
      client.send_message_event(room, 'm.room.message',
                                msgtype: @msgtype,
                                body: notification.to_markdown,
                                formatted_body: notification.to_html,
                                format: 'org.matrix.custom.html')
    end

    private

    def client
      #MatrixSdk::Api.new Setting[:notification_send_target_url], access_token: Setting[:notification_send_token]
      MatrixSdk::Api.new @hs_url, access_token: @access_token
    end

    def room
      @room ||= begin
        room = @room
        room = MatrixSdk::MXID.new(room) unless room.is_a? MatrixSdk::MXID
        room = client.join_room(room).room_id if room.room_alias?
        room
      end
    end
  end
end
