class DocumentSerializer < Serializer

  def initialize(object:)
    super(object: object)
  end

  # def serialize_as_json
  #   { documents: serialize }.to_json()
  # end

  private def get_serialized_object
    { documents: serialize_each_document }
  end

  private def serialize_each_document
    if @object.respond_to?(:map)
      @object.map { |document| serialize_single_document(document) }
    else
      [ serialize_single_document(@object) ]
    end
  end

  private def serialize_single_document(document)
    {
      id: document.id,
      type: "document",
      name: document.filename,
      content_type: document.content_type,
      extension: document.file_extension,
      byte_size: document.byte_size,
      created_at: DateFormatter.format_date(document.created_at),
      updated_at: DateFormatter.format_date(document.updated_at)
    }
  end

end

