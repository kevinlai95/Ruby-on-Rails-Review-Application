class AddCategoryIdToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :category_id, :integer
  end
end
