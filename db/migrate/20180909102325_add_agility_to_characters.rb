class AddAgilityToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :agility, :integer
  end
end
