require 'spec_helper'

describe BrothersController do

  describe "GET 'profile'" do
    it "returns http success" do
      get 'profile'
      response.should be_success
    end
  end

end
