class UserSearchesController < ApplicationController
  def new
    @user_search = UserSearch.new(session[:search] || {})
  end

  def create
    @user_search = UserSearch.new(params[:user_search])
    if @user_search.valid?
      @search = User.search(@user_search.attributes)
      @users = @search.all
    else
      render :new
    end
  end
end
