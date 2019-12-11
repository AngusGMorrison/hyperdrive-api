class Serializer

  def serialize_as_json
    serialize.to_json
  end

  private get_included_serializer(inclusion)
    class_name = inclusion.respond_to?(:first) ? inclusion.first.class.name : inclusion.class.name
    serializer_name = class_name + 'Serializer'
    serializer_name.constantize.new(target: inclusion)
  rescue NameError
    raise SerializerNotFound(serializer_name)
  end

end