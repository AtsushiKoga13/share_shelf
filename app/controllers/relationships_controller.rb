class RelationshipsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:create ,:destroy]

  def create
    current_user = User.find(session[:user_id])
    user = User.find(params[:id])
    current_user.follow(user)
    user.create_follow_post(current_user)
  end

  def destroy
    current_user = User.find(session[:user_id])
    user = User.find(params[:id])
    current_user.unfollow(user)
  end
end
