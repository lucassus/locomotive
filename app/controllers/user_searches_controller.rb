class UserSearchesController < ApplicationController
  def new
    @user_search = UserSearch.new(session[:search] || {})
  end

  def create
    @user_search = UserSearch.new(params[:user_search])
    if @user_search.valid?
      # All search params are valid, perform users search with meta_search

      # Store search attributes in the session
      search_attributes = @user_search.attributes
      session[:search] = search_attributes

      @search = User.search(search_attributes)
      @users = @search.all
    else
      render :new
    end
  end
end
