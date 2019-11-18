class UserController < ApplicationController

  def sign_up
    @user = User.create(user_params)
    if @user.valid?
      respond_with_user_and_token
    else
      render json: { user.errors }, status: 400
    end
  end

  def sign_in
  end

  private def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  private def respond_with_user_and_token
    token = get_token({ user_id: @user.id })
    user_serializer = UserSerializer.create(user: @user)
    response = user_serializer.serialize_user_as_json_with_token(token)
    render json: response, status: 200
  end

end
