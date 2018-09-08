module FightsHelper
  def digest_fight_history(fight)
    fight_history = fight.fight_history
    first_fighter = fight.first_fighter
    second_fighter = fight.second_fighter

    sweet_story = []
    sweet_story.push("The fight opposing #{first_fighter.name}(#{first_fighter.hp} hp and #{first_fighter.attack_points} attack) to #{second_fighter.name}(#{second_fighter.hp} hp and #{second_fighter.attack_points} attack) has begun !")
    fight_history.each do |turn|
      turn = eval(turn)
      playing_name = Character.find(turn[:player_playing]).name
      sweet_story.push(playing_name.capitalize + " attack !")
      sweet_story.push("#{first_fighter.name} : #{turn[:p1_hp]} left and #{second_fighter.name} : #{turn[:p2_hp]}")
    end
    sweet_story.push("#{fight.loser.name} is dead, the fight is over.")
    sweet_story.push("#{fight.winner.name} is victorious !")
    return sweet_story
  end

  def available_weapons
    weapons = [
        {'name' => 'Excalibur', 'multiplier' => 3},
        {'name' => 'Knife', 'multiplier' => 2},
        {'name' => 'Baseball bat', 'multiplier' => 1.5},
        {'name' => 'Spoon', 'multiplier' => 0.8}
      ]
  end
end
