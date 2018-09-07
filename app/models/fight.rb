class Fight < ApplicationRecord
  attr_accessor :first_fighter_id
  attr_accessor :second_fighter_id

  belongs_to :first_fighter, :class_name => "Character"
  belongs_to :second_fighter, :class_name => "Character"
  has_one :winner, :class_name => "Character"
  has_one :loser, :class_name => "Character"

  validate :fighters_are_differents

  def fighters_are_differents
    errors.add(:first_fighter, "can't be fighting himself") if first_fighter == second_fighter
  end
end
