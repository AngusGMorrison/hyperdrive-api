class DriveController < ApplicationController

  def show
    @current_user = get_current_user
    respond_with_user_files
  end

  private def respond_with_user_files
    @files = @current_user.root_folder.files
  end

end
