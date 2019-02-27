# == Schema Information
#
# Table name: delivery_statuses
#
#  id             :bigint(8)        not null, primary key
#  delivered?     :boolean          default(FALSE)
#  timeline       :string           default("normal")
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  normal_time    :integer
#  date_delivered :datetime
#

class DeliveryStatus < ApplicationRecord
  validates_inclusion_of :delivered?, { in: [true, false] }
  validates :timeline, inclusion: { in: ['normal','not normal', 'very late'] }, presence: true

  after_save :calculate_normal_time

  has_one :order
  has_one :vendor, through: :orders, source: :vendor
  has_one :user, through: :orders, source: :user

  private

  def calculate_normal_time
    if self.delivered?
      delivery_time = self.created_at - self.delivered_at
      
      self.normal_time = self.normal_time + (()) 
    end
  end
end


# how to calculate normal time?
# based specificially on vendor shipping to this specific location
# right now, delivery status only knows a few things

# do I need to convert address column on order table into location_id and have location model?
