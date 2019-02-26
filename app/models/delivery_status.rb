# == Schema Information
#
# Table name: delivery_statuses
#
#  id          :bigint(8)        not null, primary key
#  delivered?  :boolean          default(FALSE)
#  timeline    :string           default("normal")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  normal_time :integer
#

class DeliveryStatus < ApplicationRecord
  validates :delivered?, presence: true
  validates :timeline, inclusion: { in: ['normal','not normal', 'very late'] }, presence: true

  has_many :orders
  has_many :vendors, through: :orders, source: :vendor
  has_many :users, through: :orders, source: :user
end


# how to calculate normal time?
# based specificially on vendor shipping to this specific location
# right now, delivery status only knows a few things

# do I need to convert address column on order table into location_id and have location model?