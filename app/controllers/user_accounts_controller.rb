class UserAccountsController < ApplicationController

  def index
    @accounts = current_user.accounts
  end

  # callback used for create an account
  def create
    logger.info short_auth_hash.to_yaml

    provider = auth_hash[:provider]
    uid = auth_hash[:uid]

    account = UserAccount.find_by_provider_and_uid(provider, uid)
    if account.present?
      # User is already connected to the given account
      flash[:success] = 'Signed in successfully.'
      sign_in_and_redirect(:user, account.user)
    else
      if current_user.present?
        # Connect logged user to the given account
        token = auth_hash[:credentials][:token]
        current_user.connect_to(provider, :uid => uid, :token => token, :auth_response => short_auth_hash)

        flash[:success] = 'Authentication successful.'
        redirect_to user_accounts_path
      else
        # Create new user account
        session[:omniauth] = short_auth_hash
        redirect_to new_user_registration_path
      end
    end
  end

  def destroy
    account = current_user.accounts.find(params[:id])
    account.destroy

    flash[:success] = 'Account was successfully deleted.'
    redirect_to user_accounts_path
  end

  private

  def auth_hash
    ActiveSupport::HashWithIndifferentAccess.new(request.env['omniauth.auth'])
  end

  def short_auth_hash
    auth_hash.except(:extra)
  end

end
