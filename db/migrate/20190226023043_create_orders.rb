class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :order_number, null: false
      t.integer :vendor_id, null: false
      t.integer :tracking_number, null: false
      t.string :address, null: false
      t.integer :delivery_status_id
      t.integer :orderer_id

      t.timestamps
    end

    add_index :orders, :order_number
    add_index :orders, :vendor_id
    add_index :orders, :delivery_status_id
    add_index :orders, :orderer_id
  end
end
