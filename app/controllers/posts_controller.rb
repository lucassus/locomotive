class PostsController < ApplicationController
  # Renders list of recent posts
  def index
    @posts = Post.recent(10)
  end

  # Renders a post
  def show
    @post = Post.published.find(params[:id])
  end
end
