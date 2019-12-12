class DriveController < ApplicationController

  before_action :set_authorized_user

  private def set_authorized_user
    @current_user = find_authorized_user
  end

  private def current_user_serializer
    UserSerializer.new(object: @current_user)
  end

  private def render_folder(folder, status=200)
    response_body = current_user_serializer.serialize(inclusions: [folder])
    render_success(response_body, status)
  end

end
