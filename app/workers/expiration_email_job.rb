class ExpirationEmailWorker
  include Sidekiq::Worker

  def perform(email_address)
    user = User.where(email: email_address)
    UserMailer.expire_email(user).deliver
  end
end
