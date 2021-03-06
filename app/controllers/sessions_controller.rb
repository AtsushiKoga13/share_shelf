class SessionsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to "/user/my_page"
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが違います。'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
