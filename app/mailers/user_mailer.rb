class UserMailer < ApplicationMailer
  layout 'mailer'

  def send_created_user_notification(user)
    @user = user

    mail  subject: 'User created',
          to: 'eftwenty@gmail.com',
          from: 'the.mech.mail@gmail.com'
  end
end
