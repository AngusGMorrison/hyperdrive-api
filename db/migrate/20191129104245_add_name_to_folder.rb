class AddNameToFolder < ActiveRecord::Migration[6.0]
  def change
    add_column :folders, :name, :string, null: false
  end
end
