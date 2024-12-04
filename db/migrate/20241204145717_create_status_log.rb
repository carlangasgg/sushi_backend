class CreateStatusLog < ActiveRecord::Migration[7.1]
  def change
    create_table :status_logs do |t|
      t.belongs_to :device
      t.belongs_to :local
      t.integer :last_status
      t.integer :current_status

      t.references :loggable, polymorphic: true

      t.timestamps
    end
  end
end
