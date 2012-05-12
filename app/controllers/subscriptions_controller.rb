class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery :except => :create

  def new
    @plan_code = 'annual'
    @signature = Recurly.js.sign :subscription => { :plan_code => @plan_code }
  end

  def create
    result = Recurly.js.fetch(params[:recurly_token])

    subscription = Subscription.new do |s|
      s.user = current_user
      s.recurly_uuid = result.uuid
    end

    subscription.save!
    flash[:success] = 'Subscription was successfully created!'

    redirect_to root_path
  end

end
