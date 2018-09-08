class Fight < ApplicationRecord
  attr_accessor :first_fighter_id
  attr_accessor :second_fighter_id

  belongs_to :first_fighter, :class_name => "Character"
  belongs_to :second_fighter, :class_name => "Character"
  belongs_to :winner, :class_name => "Character"
  belongs_to :loser, :class_name => "Character"

  validate :fighters_are_differents

  before_validation :make_the_fight

  def make_the_fight
    puts "SELF NIGGA"
    p1 = {:id => first_fighter.id, :hp => first_fighter.hp, :attack => first_fighter.attack_points}
    p2 = {:id => second_fighter.id, :hp => second_fighter.hp, :attack => second_fighter.attack_points}
    history = []
    i = rand(2) # Random starting player to give the weakest a chance
    while (p1[:hp].positive? && p2[:hp].positive?) do
      if (i % 2 == 0) # if p1 is playing
        p2[:hp] -= p1[:attack]
        history.push({:player_playing => p1[:id], :p1_hp => p1[:hp], :p2_hp => p2[:hp]})
      else
        p1[:hp] -= p2[:attack]
        history.push({:player_playing => p2[:id], :p1_hp => p1[:hp], :p2_hp => p2[:hp]})
      end
      i += 1
    end
    self.winner_id = p1[:hp].positive? ? first_fighter_id : second_fighter_id
    self.loser_id = p1[:hp].positive? ? second_fighter_id : first_fighter_id
    self.fight_history = history
  end

  def fighters_are_differents
    errors.add(:first_fighter, "can't be fighting himself") if first_fighter == second_fighter
  end
end
