class FolderController < DriveController

  rescue_from DriveError::FolderNotFound, with: :respond_with_error
  rescue_from DriveError::RootDeletion, with: :respond_with_error
  rescue_from DriveError::RootMove, with: :respond_with_error

  def show
    folder = params[:id] ? find_owned_folder(params[:id]) : @current_user.root_folder
    render_folder(folder)
  end

  def create
    parent_folder = find_owned_folder(params[:parent_folder_id])
    new_folder = Folder.create(
      user: @current_user,
      parent_folder: parent_folder,
      name: params[:folder][:name]
    )
    new_folder.valid? ? render_folder(parent_folder) : render_validation_errors(new_folder)
  end

  def destroy
    folder_to_destroy = find_owned_folder(params[:id])
    folder_to_render = folder_to_destory.parent_folder
    Folder.destroy_subfolder(folder_to_destroy)
    render_folder(folder_to_render)
  end

  def move
    folder_to_move = find_owned_folder(params[:id])
    destination_folder = find_folder(params[:destination_folder])
    folder_to_render = folder_to_move.parent_folder
    Folder.move_subfolder(folder_to_move, destination_folder)
    render_folder(folder_to_render)
  end

  private def find_owned_folder(id)
    Folder.find_by!(id: id, user: @current_user)
  rescue ActiveRecord::RecordNotFound
    raise DriveError::FolderNotFound
  end

  private def render_folder(folder)
    response_body = current_user_serializer.serialize_with_folder_as_json(folder)
    render json: response_body, status: 200
  end

end