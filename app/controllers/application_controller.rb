class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  private

  def authenticate_admin_user!
    user, opts = warden.authenticate!(scope: :user)

    if user.present? and user.admin?
      return user
    end

    warden.logout(:user)
    throw(:warden, scope: :user)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # pass locales to the url helper methods, see: http://guides.rubyonrails.org/i18n.html#setting-the-locale-from-the-url-params
  def default_url_options(options = {})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.default_locale != I18n.locale ? I18n.locale : nil }
  end
end
