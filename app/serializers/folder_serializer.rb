class FolderSerializer

  def initialize(folder:)
    @folder = folder
  end

  def serialize
    {
      id: @folder.id,
      name: @folder.name,
      parent_folders: @folder.parent_folder ? serialize_parent_folders(@folder.parent_folder, []) : [],
      subfolders: serialize_subfolders,
      documents: get_serialized_documents,
      created_at: DateFormatter.format_date(@folder.created_at),
      updated_at: DateFormatter.format_date(@folder.updated_at)
    }
  end

  private def serialize_parent_folders(parent, array)
    array << serialize_relative(parent)
    parent.parent_folder ? serialize_parent_folders(parent.parent_folder, array) : array
  end

  private def serialize_subfolders
    @folder.subfolders.map { |subfolder| serialize_relative(subfolder) }
  end

  private def serialize_relative(relative)
    {
      id: relative.id,
      name: relative.name,
      created_at: relative.created_at,
      updated_at: relative.updated_at
    }
  end

  private def get_serialized_documents
    doc_serializer = DocumentSerializer.new(documents: @folder.documents)
    doc_serializer.serialize()
  end

end