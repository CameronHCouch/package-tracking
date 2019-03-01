# Package Tracking App

A package tracking dashboard built using Ruby on Rails. Visitors can place orders and see the status of active, unshipped orders. To see the dashboard, either create a new account or use the Demo User button to explore.

## Installation
Download or clone this repo to your computer. First run 'bundle install', then 'bundle exec rails db:create db:migrate db:seed'. Once the database has been created and seeded, run 'rails s' to explore the site on your localhost (ex. localhost:3000).

Note: this app uses the Geocoder gem to convert user-inputted addresses to the appropriate latitude and longitude. If your order contains an ambiguous address or a nonexistent address, it will not appear on Google Maps.

## TO DO
- [ ] Update "average time" of each vendors' shipments to a given address
- [ ] Dynamically determine Google Maps' boundaries to show all markers
