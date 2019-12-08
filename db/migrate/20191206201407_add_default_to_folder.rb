class AddDefaultToFolder < ActiveRecord::Migration[6.0]
  def change
    change_column_default :folders, :level, "__subfolder__"
  end
end
