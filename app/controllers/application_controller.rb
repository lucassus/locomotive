class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  private

  def authenticate_admin_user!
    user, opts = warden.authenticate!(:scope => :user)

    if user.present? and user.admin?
      return user
    end

    warden.logout(:user)
    throw(:warden, :scope => :user)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
