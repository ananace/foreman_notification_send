# frozen_string_literal: true

class ConvertSettingsToDsl < ActiveRecord::Migration[6.0]
  def up
    Settings.where(category: 'Setting::NotificationSend').update_all(category: 'Setting')
  end
end
