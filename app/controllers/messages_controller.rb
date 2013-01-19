class MessagesController < ApplicationController

  def new
    email = current_user.email if user_signed_in?
    @message = Message.new(email: email)
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      NotificationsMailer.contact_us(@message).deliver

      flash[:notice] = "Message has been send."
      redirect_to root_path
    else
      render "new"
    end
  end

end
