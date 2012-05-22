class PostsController < ApplicationController
  add_breadcrumb I18n.t('links.home'), 'root_path'
  add_breadcrumb I18n.t('links.posts'), 'posts_path'

  # Renders list of recent posts
  def index
    @posts = Post.recent(10)
  end

  # Renders a post
  def show
    @post = Post.published.find(params[:id])
    add_breadcrumb @post.title, post_path(@post)
  end
end
