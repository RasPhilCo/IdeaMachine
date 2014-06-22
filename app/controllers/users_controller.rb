class UsersController < ApplicationController
  before_action :signed_in_user, except: [:new, :create]
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

  def show
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
                                   :password_confirmation
                                  )
    end
end
