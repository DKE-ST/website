require 'rails_helper'

RSpec.describe Chapter::PublicPage, :type => :model do
  it "has a valid factory" do
    FactoryGirl.create(:chapter_public_pages).should be_valid
  end
  
  it "should be invalid without a pname" do
    FactoryGirl.build(:chapter_public_pages, pname: nil).should_not be_valid
  end
  
  it "should be invalid without a unique pname" do
    FactoryGirl.create(:chapter_public_pages, pname: "test_page").should be_valid
    FactoryGirl.build(:chapter_public_pages, pname: "test_page").should_not be_valid
  end
  
  it "should be invalid without a title" do
    FactoryGirl.build(:chapter_public_pages, title: nil).should_not be_valid
  end
  
  it "should be invalid without content" do
    FactoryGirl.build(:chapter_public_pages, content: nil).should_not be_valid
  end
  
end
