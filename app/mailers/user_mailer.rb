class UserMailer < ActionMailer::Base
  default from: "giggityinfo@gmail.com"

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Giggity!")
  end

  def message_notification(from, to, content)
    @from = from
    @to = to
    @content = content
    mail(to: @to.email, subject: "#{@from.display_name} just sent you a message on Giggity!")
  end

  def forgot_password(user)
    @user = user
    mail to: @user.email, subject: "Forgotten password on Giggity."
  end

end
