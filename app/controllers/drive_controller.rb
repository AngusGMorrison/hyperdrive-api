class DriveController < ApplicationController

  rescue_from DriveError::FileNotFound, with: :respond_to_error

  def show
    @current_user = get_current_user
    respond_with_user_files
  end

  private def respond_with_user_files
    documents = @current_user.root_folder.documents
    user_serializer = UserSerializer.new(user: @current_user)
    response_body = user_serializer.serialize_with_documents_as_json(documents)
    render json: response_body, status: 200
  end

  def create
    current_user = get_current_user
    folder = current_user.root_folder
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
    doc_serializer = DocumentSerializer.new(documents: @document)
    response_body = doc_serializer.serialize_as_json()
    render json: response_body, status: 200
  end

  def delete_file
    current_user = get_current_user
    document = find_document
    document.destroy()
    render status: 200
  end

  private def find_document
    begin
      Document.find_by!(id: params[:file_id], user: current_user)
    rescue ActiveRecord::RecordNotFound
      raise DriveError::FileNotFound
    end
  end

  def file_params
    params.permit(:file)
  end


end
