class AddNotificationTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :notification_targets do |t|
      t.string :name, null: false, unique: true

      t.string :backend, null: false
      t.json :filter, null: false
      t.json :configuration, null: false

      t.timestamps null: false
    end
  end
end

