class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :customer_id
      t.text :description
      t.date :due_date
      t.string :status
      t.string :payment_status

      t.timestamps
    end
  end
end
