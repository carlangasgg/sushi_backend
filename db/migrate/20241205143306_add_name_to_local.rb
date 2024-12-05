class AddNameToLocal < ActiveRecord::Migration[7.1]
  def change
    add_column :locals, :name, :string
  end
end
