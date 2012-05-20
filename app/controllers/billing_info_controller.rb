class BillingInfoController < ApplicationController
  protect_from_forgery :except => :create

  def edit
    account = Recurly::Account.find(current_user.recurly_account_code)
    @billing_info = account.billing_info
  end

  def create
    result = Recurly.js.fetch(params[:recurly_token])
    logger.info result

    flash[:success] = 'Billing was successfully updated!'

    redirect_to subscriptions_path
  end
end
