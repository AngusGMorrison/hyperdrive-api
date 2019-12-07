class ApplicationController < ActionController::API
  include Error::ErrorHandler

  # rescue_from UserError::Unauthorized, with: :respond_with_error
  # rescue_from ActionController::ParameterMissing, with: :respond_with_error

  # private def respond_with_error(error)
  #   render json: { errors: error.message }, status: error.status || 400
  # end

  private def find_authorized_user
    user_id = decode_token.first['user_id']
    User.find(user_id)
  rescue StandardError
    raise UnauthorizedUser
  end

  private def issue_token(payload)
    JWT.encode(payload, secret)
  end

  private def decode_token
    token = request.headers["Authorization"]
    JWT.decode(token, secret)
  end

  private def secret
    ENV['JWT_SECRET_KEY']
  end

  private def current_user_serializer
    UserSerializer.new(user: @current_user)
  end

  private def render_validation_errors(model)
    render json: { errors: model.errors }, status: 400
  end

end
