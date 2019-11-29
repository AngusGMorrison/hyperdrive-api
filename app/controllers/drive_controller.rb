class DriveController < ApplicationController

  rescue_from DriveError::DocumentNotFound, with: :respond_to_error
  
  def show
    @current_user = get_current_user
    folder = Folder.find_by(id: params[:folder_id], user_id: @current_user.id)
    user_serializer = UserSerializer.new(user: @current_user)
    response_body = user_serializer.serialize_with_folder_as_json(folder)
  end

  def create
    @current_user = get_current_user
    @document = Document.create(
      user_id: @current_user.id,
      folder: @current_user.root_folder,
      filename: params[:file].original_filename,
      content_type: params[:file].content_type,
      byte_size: params[:file].size
    )
    @document.file_data.attach(params[:file])
    respond_with_document
  end

  def delete_document
    @current_user = get_current_user
    @document = find_document
    @document.destroy()
    respond_with_document
  end

  private def respond_with_document
    if @document.valid?
      user_serializer = UserSerializer.new(user: @current_user)
      response_body = user_serializer.serialize_with_documents_as_json(@document)
      render json: response_body, status: 200
    else
      render json: { errors: @document.errors }, status: 400
    end
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

  def file_params
    params.permit(:file)
  end


end
