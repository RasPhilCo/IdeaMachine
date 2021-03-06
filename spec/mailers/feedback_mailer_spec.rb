require "spec_helper"

describe FeedbackMailer do
  describe "feedback_email" do
    let(:mail) { FeedbackMailer.feedback_email }

    it "renders the headers" do
      mail.subject.should eq("Feedback email")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
