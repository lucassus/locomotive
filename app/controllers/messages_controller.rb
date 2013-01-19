class MessagesController < ApplicationController

  def new
    @message = Message.new
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
