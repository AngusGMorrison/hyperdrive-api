module Authenticator

  private def issue_token(payload)
    JWT.encode(payload, secret)
  end
  
  private def find_authorized_user
    user_id = decode_token.first['user_id']
    User.find(user_id)
  rescue StandardError
    raise UnauthorizedUser
  end

  private def decode_token
    token = request.headers["Authorization"]
    JWT.decode(token, secret)
  end

  private def secret
    ENV['JWT_SECRET_KEY']
  end

end