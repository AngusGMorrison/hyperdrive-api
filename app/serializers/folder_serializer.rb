class FolderSerializer < Serializer

  def initialize(object:)
    super(object: object)
  end

  private def get_serialized_object
    { 
      folder: {
        id: @object.id,
        type: FILE_TYPES[:folder],
        name: @object.name,
        level: @object.level,
        parent_folders: @object.parent_folder ? serialize_parent_folders(@object.parent_folder, []) : [],
        subfolders: serialize_subfolders,
        documents: get_serialized_documents,
        created_at: DateFormatter.format_date(@object.created_at),
        updated_at: DateFormatter.format_date(@object.updated_at)
      }
    }
  end

  private def serialize_parent_folders(parent, array)
    array << serialize_relative(parent)
    parent.parent_folder ? serialize_parent_folders(parent.parent_folder, array) : array
  end

  private def serialize_subfolders
    @object.subfolders.map { |subfolder| serialize_relative(subfolder) }
  end

  private def serialize_relative(relative)
    {
      id: relative.id,
      type: "folder",
      name: relative.name,
      level: relative.level,
      created_at: relative.created_at,
      updated_at: relative.updated_at
    }
  end

  private def get_serialized_documents
    doc_serializer = DocumentSerializer.new(object: @object.documents)
    serialized_documents = doc_serializer.serialize()
    serialized_documents[:documents]
  end

end