class CreatePos < ActiveRecord::Migration[7.1]
  def change
    create_table :poses do |t|
      t.belongs_to :local, foreign_key: true
      t.string :name
      t.integer :status

      t.timestamps
    end

    create_table :printers do |t|
      t.belongs_to :local, foreign_key: true
      t.string :name
      t.integer :status

      t.timestamps
    end

    create_table :red_systems do |t|
      t.belongs_to :local, foreign_key: true
      t.string :name
      t.integer :status

      t.timestamps
    end
  end
end
