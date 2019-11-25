class DriveController < ApplicationController

  rescue_from DriveError::FileNotFound, with: :respond_to_error

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
    folder = @current_user.root_folder
    @document = Document.create(
      folder: folder,
      filename: params[:file].original_filename,
      content_type: params[:file].content_type,
      byte_size: params[:file].size
    )
    @document.file_data.attach(params[:file])
    respond_with_new_file
  end

  private def respond_with_new_file
    new_file = @folder.files.last
    file_serializer = FileSerializer.new(files: new_file)
    response_body = file_serializer.serialize_as_json()
    render json: response_body, status: 200
  end

  def delete_file
    @current_user = get_current_user
    file = find_file
    file.purge
    render status: 200
  end

  private def find_file
    begin
      folder = Folder.where(user: @current_user).with_attached_files
      p folder.
      return nil
      # @current_user.with_attached_files.find(params[:file_id])
    rescue ActiveRecord::RecordNotFound
      raise DriveError::FileNotFound
    end
  end

  def file_params
    params.permit(:file)
  end


end
