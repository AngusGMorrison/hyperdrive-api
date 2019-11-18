class UserController < ApplicationController
  def sign_up
  end

  def sign_in
  end

  private def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  
end
