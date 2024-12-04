class StatusLog < ApplicationRecord
  belongs_to :loggable, polymorphic: true
end