class FileSerializer < Serializer
  include Rails.application.routes.url_helpers

  def initialize(files: [])
    @files = files
  end

  def serialize
    if @files.respond_to?(:map)
      @files.map { |file| serialize_single_file(file) }
    else
      [ serialize_single_file(@files) ]
    end
  end

  def serialize_single_file(file)
    {
      id: file.id,
      filename: file.filename,
      content_type: file.content_type,
      # extension: Folder.get_file_extension(file),
      byte_size: file.byte_size,
      created_at: file.created_at
    }
  end

end

