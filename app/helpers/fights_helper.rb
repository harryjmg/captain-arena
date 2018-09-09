module FightsHelper
  def retrieve_weapon_hash(weapon_name)
    available_weapons.each do |weapon|
      return weapon if weapon_name == weapon['name']
    end
    return nil
  end

  def available_weapons
    [
      {'name' => 'Excalibur', 'multiplier' => 3},
      {'name' => 'Knife', 'multiplier' => 2},
      {'name' => 'Baseball bat', 'multiplier' => 1.5},
      {'name' => 'Spoon', 'multiplier' => 0.8}
    ]
  end
end
