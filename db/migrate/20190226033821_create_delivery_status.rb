class CreateDeliveryStatus < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_statuses do |t|
      t.boolean :delivered?, default: false
      t.string :timeline, default: 'normal'

      t.timestamps
    end
  end
end
