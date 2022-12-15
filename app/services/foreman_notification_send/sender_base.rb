# frozen_string_literal: true

module ForemanNotificationSend
  class SenderBase
    def self.create_sender(backend:, **args)
      return SenderMatrix.new(**args) if backend == :matrix

      raise NotImplementedError, 'Only Matrix backend implemented at the moment'
    end

    def send_notification(_notification); end
  end
end
