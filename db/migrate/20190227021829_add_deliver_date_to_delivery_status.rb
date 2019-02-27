class AddDeliverDateToDeliveryStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :delivery_statuses, :date_delivered, :datetime
  end
end
