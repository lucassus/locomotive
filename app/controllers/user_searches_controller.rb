class UserSearchesController < ApplicationController
  def show
    search = User.search(user_search_attributes)
    @users = search.all
  end

  def new
    @user_search = UserSearch.new(user_search_attributes)
  end

  def create
    @user_search = UserSearch.new(params[:user_search])

    if @user_search.valid?
      # All search params are valid, perform users search with meta_search

      # Store search attributes in the session
      search_attributes = @user_search.attributes
      session[:user_search] = search_attributes

      redirect_to user_searches_path
    else
      render :new
    end
  end

  def destroy
    # Clean up stored in the session search params
    session[:user_search] = nil
    redirect_to user_searches_path
  end
end
