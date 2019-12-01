class FolderSerializer

  def initialize(folder:)
    @folder = folder
  end

  def serialize
    {
      id: @folder.id,
      name: @folder.name,
      parent_folders: @folder.parent_folder ? serialize_parent_folders(@folder.parent_folder, []) : [],
      documents: get_serialized_documents,
      subfolders: serialize_subfolders,
      created_at: DateFormatter.format_date(@folder.created_at),
      updated_at: DateFormatter.format_date(@folder.updated_at)
    }
  end

  private def get_serialized_documents
    doc_serializer = DocumentSerializer.new(documents: @folder.documents)
    doc_serializer.serialize()
  end

  private def serialize_parent_folders(parent, array)
    array.push({
      id: parent.id,
      name: parent.name,
      created_at: parent.created_at,
      updated_at: parent.updated_at
    })
    if parent.parent_folder
      serialize_parent_folders(parent.parent_folder, array)
    end
    array
  end

  private def serialize_subfolders
    @folder.subfolders.map do |subfolder|
      {
        folder_id: subfolder.id,
        name: subfolder.name,
        created_at: subfolder.created_at,
        updated_at: subfolder.updated_at
      }
    end
  end

end