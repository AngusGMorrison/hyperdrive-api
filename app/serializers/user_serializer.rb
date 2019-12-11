class UserSerializer < Serializer

  def initialize(target:)
    super()
    @user = target
  end

  def serialize(inclusions: nil, authorization: nil, json: false)
    @serialized_user = get_serialized_user
    merge_inclusions(inclusions) if inclusions
    merge_authorization(authorization) if authorization
    json ? @serialized_user.to_json : @serialized_user
  end

  private def get_serialized_user
    {
      id: @user.id,
      name: @user.name.titleize,
      remaining_storage: @user.remaining_storage_in_bytes,
      storage_used: @user.storage_used_in_bytes,
      storage_allowance: @user.storage_allowance
    }
  end

  private def merge_inclusions(inclusions)
    inclusions.each do |inclusion|
      serializer = get_included_serializer(inclusion)
      @serialized_user.merge!(serializer.serialize)
    end
  end

  private def merge_authorization(authorization)
    @serialized_user.merge!({ authorization: authorization });
  end

  # def serialize_with_token_as_json(token)
  #   serialize_with_token(token).to_json
  # end

  # def serialize_with_token(token)
  #   {
  #     token: token,
  #     user: serialize
  #   }
  # end

  # def serialize_with_folder_as_json(folder)
  #   serialize_with_folder(folder).to_json
  # end

  # def serialize_with_folder(folder)
  #   serialized_user = { user: serialize }
  #   folder_serializer = FolderSerializer.new(folder: folder)
  #   serialized_user[:folder] = folder_serializer.serialize()
  #   serialized_user
  # end

  # def serialize_with_documents_as_json(documents)
  #   serialize_with_documents(documents).to_json
  # end

  # def serialize_with_documents(documents)
  #   serialized_user = { user: serialize }
  #   doc_serializer = DocumentSerializer.new(documents: documents)
  #   serialized_user[:documents] = doc_serializer.serialize()
  #   serialized_user
  # end



end