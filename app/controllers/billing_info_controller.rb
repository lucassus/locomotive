class BillingInfoController < ApplicationController
  protect_from_forgery :except => :create

  def edit
    @signature = Recurly.js.sign :account => { :account_code => current_user.recurly_account_code }
  end

  def create
    result = Recurly.js.fetch(params[:recurly_token])
    logger.info result

    flash[:success] = 'Billing was successfully updated!'

    redirect_to subscriptions_path
  end
end
