class NotificationsMailer < ActionMailer::Base
  default from: "from@example.com"

  def contact_us(message)
    @message = message
    mail to: "from@example.com", subject: "Contact us form"
  end
end
