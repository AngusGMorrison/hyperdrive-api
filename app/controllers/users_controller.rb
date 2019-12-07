class UsersController < ApplicationController

  def sign_up
    @user = User.create(user_params)
    if @user.valid?
      render_success(serialize_authenticated_user, 201)
    else
      render_validation_errors(@user)
    end
  end

  private def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def sign_in
    @user = User.find_by(email: params[:user][:email])
    if valid_credentials?
      render_success(serialize_authenticated_user, 200)
    else
      raise UnauthorizedUser
    end
  end

  private def valid_credentials?
    @user && @user.authenticate(params[:user][:password])
  end

  private def serialize_authenticated_user
    token = issue_token({ user_id: @user.id })
    user_serializer = UserSerializer.new(user: @user)
    user_serializer.serialize_with_token_as_json(token)
  end

end
