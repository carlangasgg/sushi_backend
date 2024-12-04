class CreateLocal < ActiveRecord::Migration[7.1]
  def change
    create_table :locals do |t|
      t.integer :status

      t.timestamps
    end
  end
end
