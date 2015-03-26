class CreateCatagories < ActiveRecord::Migration
  def change
    create_table :catagories do |t|
      t.string :cat_type

      t.timestamps
    end
  end
end
