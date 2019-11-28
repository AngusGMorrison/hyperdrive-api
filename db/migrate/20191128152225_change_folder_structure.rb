class ChangeFolderStructure < ActiveRecord::Migration[6.0]
  def change
    drop_table :folders
    create_table :folders do |t|
      t.references :user, index: true, null: false
      t.references :parent_folder, polymorphic: true, index: { name: :index_parent_folder_on_folder }, default: nil
      t.string :level, null: false

      t.timestamps
    end
  end
end
