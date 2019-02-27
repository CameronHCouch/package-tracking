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

  before_update :update_timeline, :set_date_delivered, :update_avg_time 

  has_one :order
  has_one :vendor, through: :order, source: :vendor
  has_one :user, through: :order, source: :user

  @avg_time = nil
  @order_count = 0

# TO DO: figure out when callbacks should run to continously update normal_time

  def shipping_time_in_days
    (self.date_delivered - self.created_at) / 60 / 60 / 24
  end

  def total_num_orders
    self.vendor.orders.count
  end

  private

  def set_date_delivered
    self.date_delivered = Time.now if self.delivered?
  end

  # if there is no normal time, normal time is amnt it took to ship first item
  # otherwise, add this shipping time to the running average
  def update_avg_time
    if self.delivered? && self.date_delivered
      @order_count += 1
      if @avg_time.nil?
        @avg_time = self.shipping_time_in_days
      else
        @avg_time = @avg_time + ((self.shipping_time_in_days - @avg_time) / @order_count ) 
      end
    end
    debugger
  end

  def update_timeline
    if self.normal_time && !self.delivered?
      days_elapsed = (Time.now - self.created_at) / 60 / 60 /24
      if days_elapsed > (self.normal_time * 2)
        self.timeline = 'very late'
      elsif days_elapsed > (self.normal_time) 
        self.timeline = 'not normal'
      else
        self.timeline = 'normal'
      end
    else
      self.timeline = 'normal'
    end
  end
end


# how to calculate normal time?
# based specificially on vendor shipping to this specific location
# right now, delivery status only knows a few things
