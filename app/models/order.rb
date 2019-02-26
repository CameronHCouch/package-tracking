# == Schema Information
#
# Table name: orders
#
#  id                 :bigint(8)        not null, primary key
#  order_number       :integer          not null
#  vendor_id          :integer          not null
#  tracking_number    :integer          not null
#  address            :string           not null
#  delivery_status_id :integer
#  orderer_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Order < ApplicationRecord
  validates :order_number, :tracking_number, presence: true, uniqueness: true 
  validates :vendor_id, :address, :delivery_status_id, :orderer_id, presence: true

  belongs_to :vendor,
    foreign_key: :vendor_id,
    class_name: 'Vendor'

  belongs_to :delivery_status,
    foreign_key: :delivery_status_id,
    class_name: 'DeliveryStatus'

  belongs_to :user,
    foreign_key: :orderer_id,
    class_name: 'User'
end
