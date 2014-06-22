class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/signin'
    mail(to: @user.email, subject: 'Welcome to IdeaMachine!')
  end
end
