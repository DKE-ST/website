require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit root_path
      expect(page).to have_title('DKE Server')
    end
  end
  
end
