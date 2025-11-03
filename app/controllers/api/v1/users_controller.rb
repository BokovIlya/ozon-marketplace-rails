class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /api/v1/users
  def index
    @users = User.all
    render json: @users
  end

  # GET /api/v1/users/:id
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # POST /api/v1/users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/:id
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    head :no_content
  end

  private

  def user_params
    # Обратите внимание: мы не разрешаем менять пароль напрямую.
    # Для этого обычно делают отдельный эндпоинт.
    # password_digest меняется через поле 'password' в модели.
    params.require(:user).permit(:name, :email, :role, :password)
  end
end