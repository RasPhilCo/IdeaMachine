class FeedbackMailer < ActionMailer::Base
  default to: "admin@example.com"

  def feedback_email(email, body)
      @email = email
      @body = body

      mail(from: email, subject: 'IdeaMachine Feedback')
  end
end
