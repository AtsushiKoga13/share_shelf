class UsersController < ApplicationController
  protect_from_forgery

  def index
    users = User.all
    render json: users
  end

  def show
    user_info = []
    user = User.find(session[:user_id])
    user_info << user
    user_info << encode_base64(user.image) if user.image.attached?
    user_info << user.image.filename if user.image.attached?
    render json: user_info
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image.attach(params[:user][:image])
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
      redirect_to "/user_page"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:image)
  end

  def encode_base64(image_file)
    image = Base64.encode64(image_file.download)
    blob = ActiveStorage::Blob.find(image_file.blob_id)
    "data:#{blob[:content_type]};base64,#{image}"
  end
end
