module SubscriptionsHelper

  def new_subscription_form(plan_code, account = {})
    signature = Recurly.js.sign(:subscription => { :plan_code => plan_code })
    options = {
      'planCode' => plan_code,
      'successURL' => subscriptions_url,
      'signature' => signature,
      'account' => account
    }

    content_tag(:div, :id => 'recurly-subscription-form', :'data-options' => options.to_json) do
      # nothing here
    end
  end

  def billing_info_form(account = {}, billing_info = {})
    signature = Recurly.js.sign :account => { :account_code => current_user.recurly_account_code }
    options = {
      'successURL' => billing_info_index_url,
      'signature' => signature,
      'account' => account,
      'billingInfo' => billing_info
    }

    content_tag(:div, :id => 'recurly-billing-info-form', :'data-options' => options.to_json) do
      # nothing here
    end
  end

end
