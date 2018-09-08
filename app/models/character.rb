class Character < ApplicationRecord
  has_many :fights

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :hp, presence: true, numericality: { only_integer: true, greater_than: 79, less_than: 121 }
  validates :attack_points, presence: true, numericality: { only_integer: true, greater_than: 4, less_than: 16 }

  before_save :default_selfie
  def default_values
    if self.status.nil?
      self.selfie_url = 'https://cdn.icon-icons.com/icons2/912/PNG/128/anonymous_icon-icons.com_71781.png'
    end
  end
end
