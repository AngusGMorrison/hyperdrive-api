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

  def serialize_with_files_as_json(files)
    serialize_with_files(files).to_json
  end

  def serialize_with_files(files)
    serialized_user = { user: serialize }
    file_serializer = FileSerializer.new(files: files)
    serialized_user[:user][:files] = file_serializer.serialize()
    serialized_user
  end

  def serialize
    {
      id: @user.id,
      name: @user.name
    }
  end

end