# == Schema Information
#
# Table name: vendors
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vendor < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  
  has_many :orders
  has_many :clients, through: :orders, source: :user
end
