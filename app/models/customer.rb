class Customer < ActiveRecord::Base
  attr_accessible :city_id, :email, :name, :number
  
  belongs_to :city
  belongs_to :designation
  has_many :activities
  has_many :jobs
end
