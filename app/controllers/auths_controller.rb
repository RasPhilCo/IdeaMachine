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

  def forgot_password
  end

  def password_reset_token
    set_user
    password_reset_token = User.new_remember_token
    @user.update_attribute(:password_reset_token, User.digest(password_reset_token))
    @user.update_attribute(:password_reset_token_at, Time.now)
    PasswordResetEmailWorker.perform_async(@user.id, password_reset_token)
    redirect_to signin_path, notice: "Check your email for reset instructions."
  end

  def reset_password
    password_reset_token = params[:prt]

    begin
      @user = User.find_by_password_reset_token(User.digest(password_reset_token))
      if Time.now > (@user.password_reset_token_at + 1.day)
        redirect_to signin_path, notice: "Password reset expired."
      else
        @password_reset_token = password_reset_token
        render 'reset_password'
      end
    rescue
      redirect_to signin_path, notice: "Password reset expired."
    end
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
