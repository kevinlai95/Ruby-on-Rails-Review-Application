class AddAddressIdToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :address_id, :integer
  end
end
