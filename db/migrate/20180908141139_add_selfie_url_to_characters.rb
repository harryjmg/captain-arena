class AddSelfieUrlToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :selfie_url, :string
  end
end
