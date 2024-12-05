class Local < ApplicationRecord
  has_many :users

  enum status: { active: 0, interrupted: 1, inactive: 2 }
end