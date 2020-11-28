class PostsController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
    user = User.find(session[:user_id])
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    relationship_created_at = 
    posts = Post.where("user_id IN (#{following_ids})
                        AND post_type = 2 OR
                        user_id = :user_id AND post_type = 1",
                        user_id: user.id).limit(10)
    render json: posts
  end
end
