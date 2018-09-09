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
    p1 = {:id => first_fighter.id, :hp => first_fighter.hp, :level => first_fighter.level, :attack => first_fighter.attack_points, :agility => first_fighter.agility, :dodged => 0, :weapon => retrieve_weapon_hash(p1_weapon), :shield => retrieve_shield_hash(p1_shield) }
    p2 = {:id => second_fighter.id, :hp => second_fighter.hp, :level => second_fighter.level, :attack => second_fighter.attack_points, :agility => second_fighter.agility, :dodged => 0, :weapon => retrieve_weapon_hash(p2_weapon), :shield => retrieve_shield_hash(p2_shield) }
    i = rand(2) # Random starting player to give the weakest a chance
    while (p1[:hp].positive? && p2[:hp].positive?) do
      if (i % 2 == 0) # if p1 is playing
        dmg = damage_calculator(p2, p1)
        p2[:dodged] += 1 unless dmg.positive?
        p2[:hp] -= dmg
      else
        dmg = damage_calculator(p1, p2)
        p1[:dodged] += 1 unless dmg.positive?
        p1[:hp] -= dmg
      end
      i += 1
    end
    self.winner = Character.find(p1[:hp].positive? ? p1[:id] : p2[:id])
    self.loser = Character.find(p1[:hp].positive? ? p2[:id] : p1[:id])
    self.history = {round: i, p1_hp: p1[:hp], p2_hp: p2[:hp], p1_dodged: p1[:dodged], p2_dodged: p2[:dodged]}
  end

  def damage_calculator(defenser, attacker)
    # They have a dodging chance based on their agility
    # (100 agility = 50% chance of taking 0 dmg)
    dmg = defenser[:agility] > rand(200) ? 0 : (attacker[:attack] * attacker[:weapon]['multiplier'] + attacker[:level])
    puts "___"
    puts dmg
    dmg *= (defenser[:shield]['strength'] / 100.0)
    puts dmg
    return dmg
  end

  def handle_xp
    self.winner.gain_xp(self.loser)
  end

  def fighters_are_differents
    errors.add(:first_fighter, "can't be fighting himself") if first_fighter == second_fighter
  end
end
