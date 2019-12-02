class DriveController < ApplicationController

  rescue_from DriveError::DocumentNotFound, with: :respond_to_error
  rescue_from DriveError::FolderNotFound, with: :respond_to_error
  
  def show_root
    @current_user = get_current_user
    @folder = @current_user.root_folder
    render_folder
  end

  def show_folder
    @current_user = get_current_user
    @folder = find_folder
    render_folder
  end

  def create_document
    @current_user = get_current_user
    @folder = find_folder
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
    @document.valid? ? render_folder : render_document_errors
  end

  private def render_folder
    user_serializer = UserSerializer.new(user: @current_user)
    response_body = user_serializer.serialize_with_folder_as_json(@folder)
    render json: response_body, status: 200
  end

  def delete_document
    @current_user = get_current_user
    document = find_document
    @folder = document.parent_folder
    document.destroy()
    render_folder
  end

  private def respond_with_document
    if @document.valid?
      user_serializer = UserSerializer.new(user: @current_user)
      response_body = user_serializer.serialize_with_documents_as_json(@document)
      render json: response_body, status: 201
    else
      render_document_errors
    end
  end

  private def render_document_errors
    render json: { errors: @document.errors }, status: 400
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

  private def find_document
    begin
      Document.find_by!(id: params[:document_id], user: @current_user)
    rescue ActiveRecord::RecordNotFound
      raise DriveError::DocumentNotFound
    end
  end

  private def find_folder
    begin
      Folder.find_by!(id: params[:folder_id], user: @current_user)
    rescue ActiveRecord::RecordNotFound
      raise DriveError::FolderNotFound
    end
  end

  def file_params
    params.permit(:file)
  end


end
