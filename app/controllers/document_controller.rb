class DocumentController < DriveController

  def create
    parent_folder = @current_user.find_owned_folder(params[:document][:parent_folder_id])
    document = Document.create(
      user_id: @current_user.id,
      parent_folder: parent_folder,
      filename: params[:document].original_filename,
      content_type: params[:document].content_type,
      byte_size: params[:document].size
    )
    document.file_data.attach(params[:document])
    document.valid? ? render_folder(parent_folder) : render_validation_errors(document)
  end

  def destroy
    document = @current_user.find_owned_document(params[:id])
  end

end