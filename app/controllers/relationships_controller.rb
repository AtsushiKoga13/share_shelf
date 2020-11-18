class RelationshipsController < ApplicationController
  def create
    current_user = User.find(session[:user_id])
    user = User.find(params[:id])
    current_user.follow(user)
    user.posts.create(
      content:"#{current_user.name}さんにフォローされました。",
      image: current_user.avatar.url,
      name: current_user.name
    )
  end

  def destroy
    current_user = User.find(session[:user_id])
    user = User.find(params[:id])
    current_user.unfollow(user)
  end
end
