class ApplicationController < ActionController::API

  rescue_from HyperdriveErrors::UnauthorizedUser { respond_to_error(error) }

  private def respond_to_error(error)
    render json: { errors: error.message }, status: error.status 
  end


  private def get_current_user
    begin
      user_id = decode_token['user_id']
      User.find(user_id)
    rescue StandardError
      raise HyperdriveErrors::UnauthorizedUser
    end
  end

  private def issue_token(payload)
    JWT.encode(payload, secret)
  end

  private def decode_token
    token = request.headers.token
    JWT.decode(token, secret)
  end

  private def secret
    ENV['JWT_SECRET_KEY']
  end

end
