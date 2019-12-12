class UserSerializer < Serializer

  def initialize(object:)
    super(object: object)
  end

  private def get_serialized_object
    {
      id: @object.id,
      name: @object.name.titleize,
      remaining_storage: @object.remaining_storage_in_bytes,
      storage_used: @object.storage_used_in_bytes,
      storage_allowance: @object.storage_allowance
    }
  end

end