# frozen_string_literal: true

class ConvertSettingsToDsl < ActiveRecord::Migration[6.0]
  def up
    # rubocop:disable Rails/SkipsModelValidations
    Settings.where(category: 'Setting::NotificationSend').update_all(category: 'Setting')
    # rubocop:enable Rails/SkipsModelValidations
  end
end
