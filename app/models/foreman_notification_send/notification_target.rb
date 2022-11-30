# frozen_string_literal: true

module ForemanNotificationSend
  class NotificationTarget < ApplicationRecord
    before_validation do
      # backend = slugify_backend if backend
    end
    validate :validate_backend

    def should_send?(notification)
      # TODO: Filter
    end

    def send(notification)
      sender = SenderBase.create_sender(configuration.deep_symbolize_keys.merge(backend: slugify_backend))
      sender.send_notification(notification)
    end

    def slugify_backend
      backend.to_s.downcase.to_sym
    end

    def validate_backend
      errors.add(:backend, 'is not a valid backend') if backend != :matrix
    end
  end
end
