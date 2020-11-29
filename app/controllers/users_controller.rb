class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  protect_from_forgery

  def index
    render json: User.all
  end

  def show
    params[:id] = session[:user_id] if params[:id] == "my_page"
    render json: User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to "/user/my_page"
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(session[:user_id])
    @url = @user.avatar.url.gsub(/http:/, 'https:')
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update(user_params)
      redirect_to "/user/my_page"
    else
      render :edit
    end
  end

  def following
    users = current_user.following
    render json: users
  end

  def followers
    users = current_user.followers
    render json: users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :avatar)
  end
end
