class CreateUser < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.belongs_to :local
      t.string :name

      t.timestamps
    end
  end
end
