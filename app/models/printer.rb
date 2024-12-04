class Printer < ApplicationRecord
  belongs_to :deviceable, polymorphic: true

  enum status: { active: 0, interrupted: 1, inactive: 2 }

  validates :status, inclusion: { in: statuses.keys }
  validates :name, presence: true
end