class ApplicationController < ActionController::API
  include Authenticator
  include Error::ErrorHandler

  private def render_success(body="Success!", status=200)
    render json: body, status: status
  end

  private def render_validation_errors(model)
    render json: { errors: model.errors }, status: 400
  end

  # private def find_authorized_user
  #   user_id = decode_token.first['user_id']
  #   User.find(user_id)
  # rescue StandardError
  #   raise UnauthorizedUser
  # end

  # private def issue_token(payload)
  #   JWT.encode(payload, secret)
  # end

  # private def decode_token
  #   token = request.headers["Authorization"]
  #   JWT.decode(token, secret)
  # end

  # private def secret
  #   ENV['JWT_SECRET_KEY']
  # end



end
