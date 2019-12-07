class FolderController < DriveController

  # rescue_from DriveError::FolderNotFound, with: :respond_with_error
  # rescue_from DriveError::RootDeletion, with: :respond_with_error
  # rescue_from DriveError::RootMove, with: :respond_with_error

  def show
    folder = params[:id] ? @current_user.find_owned_folder(params[:id]) : @current_user.root_folder
    render_folder(folder)
  end

  def create
    parent_folder = @current_user.find_owned_folder(params[:parent_folder_id])
    new_folder = Folder.create(
      user: @current_user,
      parent_folder: parent_folder,
      name: params[:folder][:name]
    )
    new_folder.valid? ? render_folder(parent_folder) : render_validation_errors(new_folder)
  end

  def destroy
    folder_to_destroy = @current_user.find_owned_folder(params[:id])
    folder_to_render = folder_to_destory.parent_folder
    Folder.destroy_subfolder(folder_to_destroy)
    render_folder(folder_to_render)
  end

  def move
    folder_to_move = @current_user.find_owned_folder(params[:id])
    destination_folder = @current_user.find_owned_folder(params[:destination_folder])
    folder_to_render = folder_to_move.parent_folder
    Folder.move_subfolder(folder_to_move, destination_folder)
    render_folder(folder_to_render)
  end

end