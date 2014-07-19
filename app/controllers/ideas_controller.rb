class IdeasController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :edit, :update]
  before_action :set_current_user_idea,   only: [:destroy, :edit, :update]

  def create
    @idea = current_user.ideas.build(idea_params)

    if @idea.save
      redirect_to current_user, notice: 'Your idea was added!'
    else
      flash.now[:error] = 'Idea not saved.'
      @user = current_user
      @ideas = []
      render 'user/show'
    end
  end

  def edit
  end

  def update
    if @idea.update(idea_params)
      redirect_to current_user, notice: 'Your idea was updated!'
    else
      flash.now[:error] = 'Idea not saved, try again.'
      render 'edit'
    end
  end

  def destroy
    @idea.destroy
    redirect_to current_user, notice: 'Idea deleted.' 
  end

  private
    def idea_params
      params.require(:idea).permit(:content)
    end

    def set_current_user_idea
      @idea = current_user.ideas.find_by(id: params[:id])
      redirect_to root_url if @idea.nil?
    end
end
