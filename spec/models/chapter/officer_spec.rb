require 'rails_helper'

RSpec.describe Chapter::Officer, :type => :model do
  it "has a valid factory" do
    FactoryGirl.create(:chapter_officer).should be_valid
  end
  
  it "should be invalid without a name" do
    FactoryGirl.build(:chapter_officer, name: nil).should_not be_valid
  end
  
  it "should be invalid without a unique name" do
    FactoryGirl.create(:chapter_officer, name: "test_name").should be_valid
    FactoryGirl.build(:chapter_officer, name: "test_name").should_not be_valid
  end
  
  it "should be invalid without a title" do
    FactoryGirl.build(:chapter_officer, title: nil).should_not be_valid
  end
  
  it "should be invalid without a unique title" do
    FactoryGirl.create(:chapter_officer, title: "test_title").should be_valid
    FactoryGirl.build(:chapter_officer, title: "test_title").should_not be_valid
  end
  
  it "should be invalid without a position" do
    FactoryGirl.build(:chapter_officer, position: nil).should_not be_valid
  end
  
  it "should be invalid with display = 1 and content empty" do
    FactoryGirl.build(:chapter_officer, disp: true, contact: nil).should_not be_valid
  end
end
