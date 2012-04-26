class EncountersController < ApplicationController
  before_filter :authenticate_user!

  def new
    not_encountered_users = current_user.not_encountered_users
    @users_to_encounter_count = not_encountered_users.count
    @other_user = not_encountered_users.first

    if @other_user.present?
      @encounter = Encounter.new do |e|
        e.user = current_user
        e.other_user = @other_user
      end
    end
  end

  def create
    @encounter = Encounter.new do |e|
      e.user = current_user
      e.other_user_id = params[:encounter][:other_user_id]
      e.interest_type = params[:encounter][:interest_type]
    end

    @encounter.save!
    redirect_to new_encounter_path
  end
end
