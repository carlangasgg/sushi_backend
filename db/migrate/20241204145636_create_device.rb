class CreateDevice < ActiveRecord::Migration[7.1]
  def change
    create_table :devices do |t|
      t.belongs_to :local
      t.string :name
      t.integer :status

      t.references :deviceable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
