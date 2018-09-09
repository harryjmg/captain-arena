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

  def make_the_fight
    p1 = {:id => first_fighter.id, :hp => first_fighter.hp, :attack => first_fighter.attack_points, :agility => first_fighter.agility, :dodged => 0, :weapon => retrieve_weapon_hash(p1_weapon)}
    p2 = {:id => second_fighter.id, :hp => second_fighter.hp, :attack => second_fighter.attack_points, :agility => second_fighter.agility, :dodged => 0, :weapon => retrieve_weapon_hash(p2_weapon)}
    i = rand(2) # Random starting player to give the weakest a chance
    while (p1[:hp].positive? && p2[:hp].positive?) do
      if (i % 2 == 0) # if p1 is playing
        dmg = damage_calculator(p2[:agility], p1[:attack], p1[:weapon])
        p2[:dodged] += 1 unless dmg.positive?
        p2[:hp] -= dmg
      else
        dmg = damage_calculator(p1[:agility], p2[:attack], p2[:weapon])
        p1[:dodged] += 1 unless dmg.positive?
        p1[:hp] -= dmg
      end
      i += 1
    end
    self.winner = Character.find(p1[:hp].positive? ? p1[:id] : p2[:id])
    self.loser = Character.find(p1[:hp].positive? ? p2[:id] : p1[:id])
    self.history = {round: i, p1_hp: p1[:hp], p2_hp: p2[:hp], p1_dodged: p1[:dodged], p2_dodged: p2[:dodged]}
  end

  def damage_calculator(agility, damage, weapon)
    # They have a dodging chance based on their agility
    # (100 agility = 50% chance of taking 0 dmg)
    agility > rand(200) ? 0 : (damage * weapon['multiplier'])
  end

  def fighters_are_differents
    errors.add(:first_fighter, "can't be fighting himself") if first_fighter == second_fighter
  end
end
