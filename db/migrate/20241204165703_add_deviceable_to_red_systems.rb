class AddDeviceableToRedSystems < ActiveRecord::Migration[7.1]
  def change
    add_reference :red_systems, :deviceable, polymorphic: true, null: false
  end
end
