class StaticPagesController < ApplicationController
  def feedback
  end

  def send_feedback
    name = params[:name]
    email = params[:email]
    body = params[:comments]

    FeedbackEmailWorker.perform_async(email, body)

    redirect_to feedback_path, notice: 'Feedback sent!'
  end

  def about
  end
end
