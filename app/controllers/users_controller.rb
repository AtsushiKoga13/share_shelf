class UsersController < ApplicationController
  protect_from_forgery

  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(1)
    render json: user
  end

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     redirect_to root_path
  #   else
  #     render 'new'
  #   end
  # end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end