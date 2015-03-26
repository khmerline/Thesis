class AddCatagoryIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :catagory_id, :integer
  end
end
