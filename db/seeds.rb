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

demo = User.create!(username: 'demo', password: 'password')
admin = User.create!(username: 'admin', password: 'password')

address1 = '30 Westminster Rd, Brooklyn, NY'
address2 = '22 W 38th St, New York, NY 10018'

50.times do |_|
  Vendor.create!(name: Faker::Company.unique.name)
end

200.times do |idx|
  puts "#{idx}"
  Order.create(
    order_number: Faker::Number.unique.number(5),
    vendor_id: Vendor.all.sample.id,
    tracking_number: Faker::Number.unique.number(9),
    address: [address1, address2].sample,
    delivery_status_id: DeliveryStatus.create!(
                        delivered?: [true, false].sample,
                        timeline: ['normal', 'not normal', 'very late'].sample
                        ).id,
    user_id: [demo.id, admin.id].sample
  )
end