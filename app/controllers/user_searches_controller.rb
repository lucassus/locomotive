class UserSearchesController < ApplicationController
  def new
    @user_search = UserSearch.new(session[:user_search])
  end

  def create
    @user_search = UserSearch.new(params[:user_search])
    if @user_search.valid?
      # All search params are valid, perform users search with meta_search

      # Store search attributes in the session
      search_attributes = @user_search.attributes
      session[:user_search] = search_attributes

      @search = User.search(search_attributes)
      @users = @search.all
    else
      render :new
    end
  end

  def destroy
    session[:user_search] = nil
    redirect_to root_path
  end
end
