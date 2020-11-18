class PostsController < ApplicationController
  def index
    user = User.find(session[:user_id])
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    posts = Post.where("user_id IN (#{following_ids})
                        OR user_id = :user_id", user_id: user.id).limit(10)
    render json: posts
  end
end
