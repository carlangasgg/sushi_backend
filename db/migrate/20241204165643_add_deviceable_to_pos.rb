class AddDeviceableToPos < ActiveRecord::Migration[7.1]
  def change
    add_reference :poses, :deviceable, polymorphic: true, null: false
  end
end
