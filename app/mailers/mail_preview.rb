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
end