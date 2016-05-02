class UserMailer < ApplicationMailer
  layout 'mailer'

  def send_created_user_notification(user)
    @user = user

    mail  subject: 'User created',
          to: 'to_someone@mail.somewhere',
          from: 'from_someone@mail.somewhere'
  end
end
