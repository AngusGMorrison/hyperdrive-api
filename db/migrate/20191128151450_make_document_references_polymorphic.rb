class MakeDocumentReferencesPolymorphic < ActiveRecord::Migration[6.0]
  def change
    remove_reference :documents, :folder
    add_reference :documents, :parent_folder, polymorphic: true, index: { name: :index_parent_folder_on_document }, null: false
  end
end
