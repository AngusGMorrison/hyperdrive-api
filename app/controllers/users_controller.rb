class UsersController < ApplicationController

  def sign_up
    @user = User.create(user_params)
    if @user.valid?
      respond_with_user_and_token
    else
      render json: { errors: user.errors }, status: 400
    end
  end

  def sign_in
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      respond_with_user_and_token
    else
      render json: { errors: UserError::INCORRECT_LOGIN }, status: 403
    end
  end

  private def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  private def respond_with_user_and_token
    token = issue_token({ user_id: @user.id })
    user_serializer = UserSerializer.create(user: @user)
    response = user_serializer.serialize_with_token_as_json(token)
    render json: response, status: 200
  end

end
