class PostsController < ApplicationController
  def index
    @posts = Post.recent(10)
  end

  def show
    @post = Post.published.find(params[:id])
  end
end
