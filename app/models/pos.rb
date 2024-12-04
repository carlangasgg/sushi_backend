class Pos < ApplicationRecord
  self.table_name = "poses"
  belongs_to :deviceable, polymorphic: true
  has_many :status_logs, as: :loggable

  enum status: { active: 0, interrupted: 1, inactive: 2 }

  validates :status, inclusion: { in: statuses.keys }
  validates :name, presence: true

  after_update :log_status_change, if: :saved_change_to_status?

  private

  def log_status_change
    status_logs.create!(
      device_id: id,
      local_id: local_id,
      last_status: status_before_last_save && Pos.statuses[status_before_last_save],
      current_status: Pos.statuses[status] )
  end
end