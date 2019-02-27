# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Vendor.destroy_all
Order.destroy_all
DeliveryStatus.destroy_all

demo = User.create!(username: 'Demo', password: 'password')
admin = User.create!(username: 'Admin', password: 'password')

address1 = '30 Westminster Rd, Brooklyn, NY 11218'
address2 = '22 W 38th St, New York, NY 10018'
address3 = 'Times Square, NYC'

vendor_hash = {}

3.times do |idx|
  vendor = Vendor.create!(name: Faker::Company.unique.name)
  vendor_hash[idx] = vendor.id
end

def create_delivery_status
  new_ds = DeliveryStatus.new(
                    delivered?: [true, false].sample,
                    timeline: ['normal', 'not normal', 'very late'].sample,
                    )
  if new_ds.delivered?
    new_ds.date_delivered = Time.now
    new_ds.normal_time = 3
    case new_ds.timeline
    when 'normal'
      new_ds.created_at = new_ds.date_delivered - (3600 * 24 * 3)
    when 'not normal'
      new_ds.created_at = new_ds.date_delivered - (3600 * 24 * 4.5)
    when 'very late'
      new_ds.created_at = new_ds.date_delivered - (3600 * 24 * 6)
    end
  end

  new_ds.save!
  new_ds
end


5.times do |idx|
  Order.create(
    order_number: rand(10000),
    # use vendor hash to prevent large nested loops
    vendor_id: vendor_hash[rand(3)],
    tracking_number: rand(100000000),
    address: [address1, address2, address3].sample,
    delivery_status_id: create_delivery_status.id,
    user_id: demo.id
  )
end