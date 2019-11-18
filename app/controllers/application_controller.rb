class ApplicationController < ActionController::API

  private def get_token(payload)
    JWT.issue_token(payload, ENV['JWT_SECRET_KEY'])
  end

end
