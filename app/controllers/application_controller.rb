class ApplicationController < ActionController::API

  private def get_token(payload)
    JWT.issue_token(payload, )
  end

  end

end
