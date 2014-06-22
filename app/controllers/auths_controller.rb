class AuthsController < ApplicationController
  def new
    if signed_in?
      redirect_to current_user
    end
  end

  def create
    set_user
    if @user && @user.authenticate(params[:auth][:password])
      sign_in @user
      redirect_to @user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private
    def set_user
      check_username_or_email(params[:auth][:email_or_username])

      if @is_email
        @user = User.find_by(email: params[:auth][:email_or_username].downcase)
      else
        @user = User.find_by(username: params[:auth][:email_or_username].downcase)
      end
    end

    def check_username_or_email(email_or_username)
      if User::VALID_EMAIL_REGEX =~ email_or_username
        @is_email= true
      else
        @is_email = false
      end
    end
end
