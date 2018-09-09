class Fight < ApplicationRecord
  include FightsHelper

  attr_accessor :first_fighter_id
  attr_accessor :second_fighter_id

  belongs_to :first_fighter, :class_name => "Character"
  belongs_to :second_fighter, :class_name => "Character"
  belongs_to :winner, :class_name => "Character", optional: true
  belongs_to :loser, :class_name => "Character", optional: true

  validate :fighters_are_differents

  after_validation :make_the_fight
  after_create :handle_xp

  def make_the_fight
    players = [
      {:id => first_fighter.id, :hp => first_fighter.hp, :level => first_fighter.level, :attack => first_fighter.attack_points, :agility => first_fighter.agility, :dodged => 0, :weapon => retrieve_weapon_hash(p1_weapon), :shield => retrieve_shield_hash(p1_shield) },
      {:id => second_fighter.id, :hp => second_fighter.hp, :level => second_fighter.level, :attack => second_fighter.attack_points, :agility => second_fighter.agility, :dodged => 0, :weapon => retrieve_weapon_hash(p2_weapon), :shield => retrieve_shield_hash(p2_shield) }
    ]
    i = rand(2) # Random starting player to give the weakest a chance
    while (players.all? { |player| player[:hp].positive?} ) do
      dmg = damage_calculator(players[1 - (i % 2)], players[i % 2])
      players[1 - (i % 2)][:dodged] += 1 unless dmg.positive?
      players[1 - (i % 2)][:hp] -= dmg
      i += 1
    end
    # The loser is the current players[(i % 2)] cuz the while breaked on him
    self.winner = Character.find(players[1 - (i % 2)][:id])
    self.loser = Character.find(players[(i % 2)][:id])
    self.history = {round: i, p1_hp: players[0][:hp], p2_hp: players[1][:hp], p1_dodged: players[0][:dodged], p2_dodged: players[1][:dodged]}
  end

  def damage_calculator(defenser, attacker)
    # They have a dodging chance based on their agility
    # (100 agility = 50% chance of taking 0 dmg)
    dmg = defenser[:agility] > rand(200) ? 0 : (attacker[:attack] * attacker[:weapon]['multiplier'] + attacker[:level])
    dmg *= (defenser[:shield]['strength'] / 100.0)
    return dmg
  end

  def handle_xp
    self.winner.gain_xp(self.loser)
  end

  def fighters_are_differents
    errors.add(:first_fighter, "can't be fighting himself") if first_fighter == second_fighter
  end
end
