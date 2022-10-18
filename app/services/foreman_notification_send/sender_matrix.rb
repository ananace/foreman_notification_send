# frozen_string_literal: true
require 'matrix_sdk/api'

module ForemanNotificationSend
  class SenderMatrix < SenderBase
    def initialize(hs_url:, access_token:, room:, msgtype: 'm.notice')
      room = MatrixSdk::MXID.new room unless room.is_a?(MatrixSdk::MXID)
      raise ArgumentError, 'room must be a Matrix room ID/Alias' unless room.room?

      @hs_url = hs_url
      @access_token = access_token
      @room_id = room
      @msgtype = msgtype

      super
    end

    def send_notification(notification)
      room.send_html(notification.to_html, notification.to_body, msgtype: @msgtype)
    end

    private

    def client
      @client ||= MatrixSdk::Client.new @hs_url, access_token: @access_token, client_cache: :some
    end

    def room
      @room ||= if @room_id.room_id?
                  @client.ensure_room(@room_id)
                else
                  @client.fetch_room(@room_id) || @client.join_room(@room_id)
                end
    end
  end
end
