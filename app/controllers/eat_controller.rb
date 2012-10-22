class EatController < ApplicationController

  def food
    job_id = Eat.create(:food => params[:food])
    render :text => "Put #{params[:food]} in fridge to eat later. Job id: #{job_id}"
  end

end
