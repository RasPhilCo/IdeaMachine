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
end