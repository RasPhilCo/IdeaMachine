class UsersController < ApplicationController
  before_action :signed_in_user, except: [:new, :create, :update_password]
  before_action :correct_user, only: [:show]

  def new
    if signed_in?
      redirect_to current_user
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        sign_in @user
        WelcomeEmailWorker.perform_async(@user.id)
        redirect_to @user, notice: 'Account created successfully!' 
      else
        render 'new'
      end
  end

  def update_password

    @user = User.find_by_password_reset_token(User.digest(params[:user][:password_reset_token]))
    if @user.update(user_params)
      @user.update_attribute(:password_reset_token, nil)
      redirect_to signin_path, notice: "Password succesfully changed!"
    else 
      render 'auths/reset_password'
    end
  end

  def show
    @ideas = current_user.ideas
    @idea  = Idea.new
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(current_user) unless current_user?(@user)
    end

    def user_params
      params.require(:user).permit(:email,
                                   :username,
                                   :password,
                                   :password_confirmation,
                                   :password_reset_token
                                  )
    end
end
