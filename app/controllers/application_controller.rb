class ApplicationController < ActionController::API
  include Authenticator
  include Error::ErrorHandler

  private def render_success(body="Success!", status=200)
    render json: body, status: status
  end

  private def render_validation_errors(model)
    render json: { errors: model.errors }, status: 400
  end

end
