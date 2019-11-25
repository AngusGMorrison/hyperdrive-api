class DriveController < ApplicationController

  def show
    @current_user = get_current_user
    respond_with_user_files
  end

  private def respond_with_user_files
    files = @current_user.root_folder.files
    user_serializer = UserSerializer.new(user: @current_user)
    response_body = user_serializer.serialize_with_files_as_json(files)
    render json: response_body, status: 200
  end

  def create
    @current_user = get_current_user
    @folder = @current_user.root_folder
    @folder.files.attach(params[:file])
    respond_with_new_file
  end

  private def respond_with_new_file
    new_file = @folder.files.last
    file_serializer = FileSerializer.new(files: new_file)
    response_body = file_serializer.serialize_as_json()
    render json: response_body, status: 200
  end

  def file_params
    params.permit(:file)
  end


end
