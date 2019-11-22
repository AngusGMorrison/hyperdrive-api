class DriveController < ApplicationController

  def show
    @current_user = get_current_user
    respond_with_user_files
  end

  private def respond_with_user_files
    folder = Folder.where(["user_id = ? AND name = ?", @current_user.id, "__root__"])
    @files = @current_user.folder
  end

end
