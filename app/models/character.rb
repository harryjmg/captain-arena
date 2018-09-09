class Character < ApplicationRecord
  has_many :fights

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :hp, presence: true, numericality: { only_integer: true, greater_than: 79, less_than: 121 }
  validates :attack_points, presence: true, numericality: { only_integer: true, greater_than: 4, less_than: 16 }
  validates :agility, presence: true, numericality: { only_integer: true, greater_than: -1, less_than: 101 }

  before_create :default_values

  def default_values
    # level starts a 0
    self.level = 1
    self.xp_points = 0
    # A selfie if he aint got one
    if self.selfie_url.nil?
      self.selfie_url = 'https://cdn.icon-icons.com/icons2/912/PNG/128/anonymous_icon-icons.com_71781.png'
    end
  end

  def gain_xp(loser)
    current_character = self
    current_character.xp_points += loser.level
    if current_character.xp_points > 5
      current_character.level += 1
      current_character.xp_points = 0
    end
    current_character.save
  end
end
