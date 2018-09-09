class AddShieldsToFights < ActiveRecord::Migration[5.2]
  def change
    add_column :fights, :p1_shield, :string
    add_column :fights, :p2_shield, :string
  end
end
