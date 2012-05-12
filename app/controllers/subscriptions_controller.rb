class SubscriptionsController < ApplicationController

  def new
    @plan_code = 'annual'
    @signature = Recurly.js.sign :subscription => { :plan_code => @plan_code }
  end

  def create
  end

end
