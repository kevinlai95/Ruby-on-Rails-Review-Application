class AddStreetToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :street, :string
  end
end
