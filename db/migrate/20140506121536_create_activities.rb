class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :customer_id
      t.datetime :start_time
      t.datetime :end_time
      t.text :feedback

      t.timestamps
    end
  end
end
