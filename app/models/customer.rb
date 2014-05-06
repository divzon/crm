class Customer < ActiveRecord::Base
  attr_accessible :city_id, :email, :name, :number
  
  belongs_to :city
  has_many :activities
end
