class UserMailer < ActionMailer::Base
  default from: "herokumailers@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://ideamachine.herokuapp.com/signin'
    mail(to: @user.email, subject: 'Welcome to IdeaMachine!')
  end

  def password_reset_email(user, password_reset_token)
    @user = user
    @url = "http://ideamachine.herokuapp.com/reset_password?prt=#{password_reset_token}"
    mail(to: @user.email, subject: 'IdeaMachine Password Reset Requested')
  end
end
