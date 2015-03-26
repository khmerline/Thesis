class AddReadMoreToProduct < ActiveRecord::Migration
  def change
    add_column :products, :read_more, :string
  end
end
