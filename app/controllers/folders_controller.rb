class FoldersController < DriveController

  def show
    folder = params[:id] ? @current_user.find_owned(:folder, params[:id]) : @current_user.root_folder
    render_folder(folder)
  end

  def create
    parent_folder = @current_user.find_owned(:folder, params[:parent_folder_id])
    new_folder = Folder.create(
      user: @current_user,
      parent_folder: parent_folder,
      name: params[:folder][:name]
    )
    new_folder.valid? ? render_folder(parent_folder, 201) : render_validation_errors(new_folder)
  end

  def move
    folder_to_move = @current_user.find_owned(:folder, params[:id])
    destination_folder = @current_user.find_owned(:folder, params[:destination_folder_id])
    folder_to_render = folder_to_move.parent_folder
    Folder.move_subfolder(folder_to_move, destination_folder)
    render_folder(folder_to_render)
  end

  def destroy
    folder_to_destroy = @current_user.find_owned(:folder, params[:id])
    folder_to_render = folder_to_destroy.parent_folder
    Folder.destroy_subfolder(folder_to_destroy)
    render_folder(folder_to_render)
  end

end