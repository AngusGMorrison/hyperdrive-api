class DriveController < ApplicationController

  rescue_from DriveError::DocumentNotFound, with: :respond_to_error
  rescue_from DriveError::FolderNotFound, with: :respond_to_error
  
  # def show_root
  #   @current_user = get_current_user
  #   @folder = @current_user.root_folder
  #   render_folder
  # end

  def show_folder
    @current_user = get_current_user
    @folder = params[:id] ? find_folder(params[:id]) : @current_user.root_folder
    render_folder
  end

  def create_document
    @current_user = get_current_user
    @folder = find_folder(params[:id])
    @document = Document.create(
      user_id: @current_user.id,
      parent_folder: @folder,
      filename: params[:file].original_filename,
      content_type: params[:file].content_type,
      byte_size: params[:file].size
    )
    @document.file_data.attach(params[:file])
    validate_document_and_respond
  end

  private def validate_document_and_respond
    @document.valid? ? render_folder : render_object_errors(@document)
  end

  def create_folder
    byebug
    @current_user = get_current_user
    @folder = find_folder(params[:parent_folder_id])
    @new_folder = Folder.create(
      user: @current_user,
      parent_folder: @folder,
      name: params[:folder][:name],
      level: Folder::LEVELS[:SUBFOLDER]
    )
    validate_folder_and_respond
  end

  private def validate_folder_and_respond
    @new_folder.valid? ? render_folder : render_object_errors(@new_folder)
  end

  private def render_folder
    user_serializer = UserSerializer.new(user: @current_user)
    response_body = user_serializer.serialize_with_folder_as_json(@folder)
    render json: response_body, status: 200
  end

  def delete_folder
    @current_user = get_current_user
    folder_to_destroy = find_folder(params[:id])
    folder_to_destroy.destroy()
    @folder = folder_to_destroy.parent_folder
    render_folder
  end

  def delete_document
    @current_user = get_current_user
    document = find_document
    document.destroy()
    @folder = document.parent_folder
    render_folder
  end

  private def respond_with_document
    if @document.valid?
      user_serializer = UserSerializer.new(user: @current_user)
      response_body = user_serializer.serialize_with_documents_as_json(@document)
      render json: response_body, status: 201
    else
      render_object_errors(@document)
    end
  end

  private def render_object_errors(object)
    render json: { errors: object.errors }, status: 400
  end

  def download_document
    @current_user = get_current_user
    @document = find_document
    send_data(
      @document.file_data.download,
      filename: @document.filename,
      disposition: 'attachment',
      status: 200
    );
  end

  def move_document
  end

  def move_folder
  end

  private def find_document
    begin
      Document.find_by!(id: params[:id], user: @current_user)
    rescue ActiveRecord::RecordNotFound
      raise DriveError::DocumentNotFound
    end
  end

  private def find_folder(id)
    begin
      Folder.find_by!(id: id, user: @current_user)
    rescue ActiveRecord::RecordNotFound
      raise DriveError::FolderNotFound
    end
  end

  def file_params
    params.permit(:file)
  end


end
