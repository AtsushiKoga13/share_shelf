class UsersController < ApplicationController
  # before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
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
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(session[:user_id])
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
    user = User.find(session[:user_id])
    users = user.following
    render json: users
  end

  def followers
    user = User.find(session[:user_id])
    users = user.followers
    render json: users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:image, :avatar)
  end

  # def encode_base64(image_file)
  #   image = Base64.encode64(image_file.download)
  #   blob = ActiveStorage::Blob.find(image_file.blob_id)
  #   "data:#{blob[:content_type]};base64,#{image}"
  # end
end
