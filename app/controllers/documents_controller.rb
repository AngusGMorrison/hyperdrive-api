class DocumentsController < DriveController

  def download
    document = @current_user.find_owned_document(params[:id])
    send_data(
      document.file_data.download,
      filename: document.filename,
      disposition: attachment,
      status: 200
    )
  end

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
    document.valid? ? render_folder(parent_folder, 201) : render_validation_errors(document)
  end

  def move
    document = @current_user.find_owned_document(params[:id])
    destination_folder = @current_user.find_owned_folder(params[:destination_folder_id])
    folder_to_render = document.parent_folder
    document.update(parent_folder: destination_folder)
    render_folder(folder_to_render)
  end

  def destroy
    document = @current_user.find_owned_document(params[:id])
    folder_to_render = document.parent_folder
    document.destroy
    render_folder(folder_to_render)
  end

end