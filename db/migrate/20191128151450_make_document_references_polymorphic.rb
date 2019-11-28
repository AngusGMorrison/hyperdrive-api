class MakeDocumentReferencesPolymorphic < ActiveRecord::Migration[6.0]
  def change
    remove_reference :documents, :folder
    add_reference :documents, :containing_folder, polymorphic: true, index: { name: :containing_folder_document_index }
  end
end
