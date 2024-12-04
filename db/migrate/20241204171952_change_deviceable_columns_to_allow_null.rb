class ChangeDeviceableColumnsToAllowNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :devices, :deviceable_type, true
    change_column_null :devices, :deviceable_id, true
  end
end
