# frozen_string_literal: true

module ForemanNotificationSend
  class SenderBase
    def self.create_sender
      SenderMatrix.new
    end

    def send_notification(_notification)
      raise NotImplementedException
    end
  end
end
