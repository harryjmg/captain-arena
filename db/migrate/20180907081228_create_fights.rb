class CreateFights < ActiveRecord::Migration[5.2]
  def change
    create_table :fights do |t|
      t.references :first_fighter
      t.references :second_fighter
      t.references :winner
      t.references :loser
      t.string :history
      t.timestamps
    end
  end
end
