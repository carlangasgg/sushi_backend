class User < ApplicationRecord
  belongs_to :local
  has_many :status_logs
end