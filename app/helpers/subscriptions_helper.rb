module SubscriptionsHelper

  def new_subscription_form(signature, plan_code, account = {})
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

end
