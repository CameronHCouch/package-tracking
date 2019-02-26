class ChangeOrderersToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :orderer_id
    add_column :orders, :user_id, :integer
    add_index :orders, :user_id
  end
end
