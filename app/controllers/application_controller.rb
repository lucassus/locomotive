class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate_admin_user!
    user, opts = warden.authenticate!(:scope => :user)

    if user.present? and user.admin?
      return user
    end

    warden.logout(:user)
    throw(:warden, :scope => :user)
  end

  def user_search_attributes
    session[:user_search] || {}
  end
end
