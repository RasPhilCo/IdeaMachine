class PasswordResetEmailWorker
  include Sidekiq::Worker

  def perform(user_id, password_reset_token)
    user = User.find(user_id)
    UserMailer.password_reset_email(user, password_reset_token).deliver
  end
end