class Device < ApplicationRecord
  has_many :poses, class_name: 'Pos', as: :deviceable
  has_many :printers, class_name: 'Printer', as: :deviceable
  has_many :red_systems, class_name: 'RedSystem', as: :deviceable

  enum status: { active: 0, interrupted: 1, inactive: 2 }

  validates :status, inclusion: { in: statuses.keys }
  validates :name, presence: true

end