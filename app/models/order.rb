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
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#  latitude           :float
#  longitude          :float
#

class Order < ApplicationRecord
  extend Geocoder::Model::ActiveRecord
  
  validates :order_number, :tracking_number, presence: true, uniqueness: true 
  validates :vendor_id, :address, :delivery_status_id, :user_id, presence: true

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  belongs_to :vendor,
    foreign_key: :vendor_id,
    class_name: 'Vendor'

  belongs_to :delivery_status,
    foreign_key: :delivery_status_id,
    class_name: 'DeliveryStatus'

  belongs_to :user,
    foreign_key: :user_id,
    class_name: 'User'
end
