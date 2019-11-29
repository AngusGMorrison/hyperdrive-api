class DocumentSerializer < Serializer

  def initialize(documents: [])
    @documents = documents
  end

  def serialize_as_json
    { documents: serialize }.to_json()
  end

  def serialize
    if @documents.respond_to?(:map)
      @documents.map { |document| serialize_single_document(document) }
    else
      [ serialize_single_document(@documents) ]
    end
  end

  def serialize_single_document(document)
    {
      id: document.id,
      filename: document.filename,
      content_type: document.content_type,
      extension: document.get_file_extension,
      byte_size: document.byte_size,
      created_at: DateFormatter.format_date(document.created_at),
      updated_at: DateFormatter.format_date(document.updated_at)
    }
  end

end

