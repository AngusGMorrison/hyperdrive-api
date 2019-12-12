class Serializer
  include Error

  def initialize(object:)
    @object = object
  end

  def serialize(inclusions: nil, authorization: nil, json: false)
    @serialized_object = get_serialized_object
    merge_inclusions(inclusions) if inclusions
    merge_authorization(authorization) if authorization
    json ? @serialized_object.to_json : @serialized_object
  end

  private def merge_inclusions(inclusions)
    inclusions.each do |inclusion|
      serializer = create_inclusion_serializer(inclusion)
      @serialized_object.merge!(serializer.serialize)
    end
  end

  private def create_inclusion_serializer(inclusion)
    serializer_class = get_serializer_class(inclusion)
    serializer_class.new(object: inclusion)
  end

  private def get_serializer_class(inclusion)
    class_name = inclusion.respond_to?(:first) ? inclusion.first.class.name : inclusion.class.name
    serializer_name = class_name + 'Serializer'
    serializer_name.constantize
  rescue NameError
    raise SerializerNotFound(serializer_name)
  end

  private def merge_authorization(authorization)
    @serialized_object.merge!({ authorization: authorization });
  end

end