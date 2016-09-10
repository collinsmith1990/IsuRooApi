class UsersController < ApplicationController
  skip_before_action :authenticate_request, only:[:create]

  def create
    @user = User.new(user_params)

    if @user.save
      command = AuthenticateUser.call(@user.email, @user.password)
      if command.success?
        @user.auth_token = command.result
        render json: @user
      else
        render json: @user.errors.add(command.errors), status: :unauthorized
      end
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all

    render json: @users
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
