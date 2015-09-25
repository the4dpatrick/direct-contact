class UserMailer < ActionMailer::Base
  default from: "no-reply@GetDirectContact.com"

  def expire_email(user)
    mail(to: user.email, subject: 'Subscription Canceled - DirectContact')
  end
end
