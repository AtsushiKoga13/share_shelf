class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(session[:user_id])
    redirect_to "/user/my_page" unless current_user?(@user)
  end
end
