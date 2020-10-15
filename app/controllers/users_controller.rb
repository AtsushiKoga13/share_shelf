class UsersController < ApplicationController
  protect_from_forgery

  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(session[:user_id])
    render json: user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    user = User.find(session[:user_id])
    if user.update(user_params)
      render plain: "true"
    else
      render plain: user.errors.full_messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end