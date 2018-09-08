class Character < ApplicationRecord
  has_many :fights

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :hp, presence: true, numericality: { only_integer: true,
                                                  greater_than: 79,
                                                  less_than: 121 }
  validates :attack_points, presence: true, numericality: { only_integer: true,
                                                            greater_than: 4,
                                                            less_than: 16 }
end
