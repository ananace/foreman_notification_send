# frozen_string_literal: true

class ConvertSettingsToDsl < ActiveRecord::Migration[6.0]
  def up
    Setting.where(category: 'Setting::NotificationSend').update_all(category: 'Setting') \
      if column_exists?(:settings, :category)
  end
end
