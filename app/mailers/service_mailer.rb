class ServiceMailer < ApplicationMailer
  layout 'mailer'

  def user_changed_service(user, service)
    @user = user
    @service = service

    mail subject: 'User updated a service',
         to: 'eftwenty@gmail.com',
         from: 'the.mech.mail@gmail.com'
  end

  def changed_service(service)
    @service = service

    mail subject: 'Service update',
         to: 'eftwenty@gmail.com',
         from: 'the.mech.mail@gmail.com'
  end

  def deleted_service(user, service)
    @user = user
    @service = service

    mail subject: 'Service was deleted',
         to: 'eftwenty@gmail.com',
         from: 'the.mech.mail@gmail.com'
  end
end