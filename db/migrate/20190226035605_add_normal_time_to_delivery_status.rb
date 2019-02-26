class AddNormalTimeToDeliveryStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :delivery_statuses, :normal_time, :integer, presence: true
  end
end
