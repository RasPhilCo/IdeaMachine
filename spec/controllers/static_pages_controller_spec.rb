require 'spec_helper'

describe StaticPagesController do

  describe "GET 'feedback'" do
    it "returns http success" do
      get 'feedback'
      response.should be_success
    end
  end

end
