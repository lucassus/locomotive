class LongJobController < ApplicationController

  def new
    length = params[:length] || 100
    job_id = SleepJob.create(:length => length)

    render :text => "Long job, length: #{length}. Job id: #{job_id}"
  end

  def status
    job_id = params[:job_id]
    status = Resque::Plugins::Status::Hash.get(job_id)
    render :text => status
  end

end
