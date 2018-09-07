class CreateFights < ActiveRecord::Migration[5.2]
  def change
    create_table :fights do |t|
      t.integer :first_fighter_id
      t.integer :second_fighter_id
      t.integer :winner_id
      t.integer :loser_id
      t.string :fight_history, array: true
      t.timestamps
    end
  end
end
