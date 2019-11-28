class ChangeFolderStructure < ActiveRecord::Migration[6.0]
  def change
    drop_table :folders
    create_table :folders do |t|
      t.references :containing_folder, polymorphic: true, index: { name: :containing_folder_folder_index }
    end
  end
end
