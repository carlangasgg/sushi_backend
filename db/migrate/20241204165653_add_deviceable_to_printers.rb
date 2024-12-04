class AddDeviceableToPrinters < ActiveRecord::Migration[7.1]
  def change
    add_reference :printers, :deviceable, polymorphic: true, null: false
  end
end
