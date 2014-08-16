class MailPreview < MailView
  def welcome
    user = User.create!(username: "example", 
                        email: "example@example.com", 
                        password:"example", 
                        password_confirmation:"example"
                       )
    mail = UserMailer.welcome_email(user)
    user.destroy
    mail
  end

  def feedback
    FeedbackMailer.feedback_email("example@example.com", "Lorum ipsum...")
  end

  def password_reset
    password_reset_token = User.new_remember_token
    user = User.create!(username: "example", 
                        email: "example@example.com", 
                        password:"example", 
                        password_confirmation:"example",
                        password_reset_token: User.digest(password_reset_token),
                        password_reset_token_at: Time.now
                       )
    mail = UserMailer.password_reset_email(user, password_reset_token)
    user.destroy
    mail
  end
end