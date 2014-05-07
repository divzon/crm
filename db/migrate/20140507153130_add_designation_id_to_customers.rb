class AddDesignationIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :designation_id, :integer
  end
end
