class AddLevelToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :level, :integer
    add_column :characters, :xp_points, :integer
  end
end
