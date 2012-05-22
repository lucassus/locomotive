class RegistrationsController < Devise::RegistrationsController

  def create
    super

    # clear session data
    session[:omniauth] = nil unless @user.new_record?
  end

  private

  def build_resource(*args)
    super

    if session[:omniauth]
      omniauth = session[:omniauth]

      @user.email = omniauth['info']['nickname'] if @user.email.blank?
      @user.accounts.build do |a|
        a.provider = omniauth['provider']
        a.uid = omniauth['uid']
        a.token = omniauth['credentials']['token']
      end
    end
  end
end
