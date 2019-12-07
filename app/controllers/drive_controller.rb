class DriveController < ApplicationController

  before_action :set_authorized_user

  private def set_authorized_user
    @current_user = find_authorized_user
  end

  private def current_user_serializer
    UserSerializer.new(user: @current_user)
  end

  private def render_folder(folder)
    response_body = current_user_serializer.serialize_with_folder_as_json(folder)
    render json: response_body, status: 200
  end

end
