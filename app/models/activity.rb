class Activity < ActiveRecord::Base
  attr_accessible :customer_id, :end_time, :feedback, :start_time
  
  belongs_to :customer
end
