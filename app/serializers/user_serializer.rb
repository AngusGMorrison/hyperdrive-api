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

  def serialize
    {
      id: @user.id,
      name: @user.name
    }
  end

end