class FeedbackEmailWorker
  include Sidekiq::Worker

  def perform(email, body)
    FeedbackMailer.feedback_email(email, body).deliver
  end
end