class Local < ApplicationRecord
  has_many :users

  enum :status, [:active, :issue, :off]
end