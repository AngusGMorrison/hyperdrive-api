class UserSerializer < Serializer

  def initialize(user:)
    super()
    @user = user
  end

  def serialize_with_token_as_json(token)
    serialize_with_token(token).to_json
  end

  def serialize_with_token(token)
    {
      token: token,
      user: serialize
    }
  end

  def serialize_with_documents_as_json(documents)
    serialize_with_documents(documents).to_json
  end

  def serialize_with_documents(documents)
    serialized_user = { user: serialize }
    doc_serializer = DocumentSerializer.new(documents: documents)
    serialized_user[:documents] = doc_serializer.serialize()
    serialized_user
  end

  def serialize
    {
      id: @user.id,
      name: @user.capitalized_name,
      remaining_storage: @user.remaining_storage_in_bytes,
      storage_used: @user.storage_used_in_bytes,
      storage_allowance: @user.storage_allowance
    }
  end

end