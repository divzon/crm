class Job < ActiveRecord::Base
  attr_accessible :customer_id, :description, :due_date, :payment_status, :status
  
  belongs_to :customer
end
