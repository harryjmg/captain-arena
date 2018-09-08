class AddWeaponsToFights < ActiveRecord::Migration[5.2]
  def change
    add_column :fights, :p1_weapon, :string
    add_column :fights, :p2_weapon, :string
  end
end
