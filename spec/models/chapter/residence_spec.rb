require 'rails_helper'

RSpec.describe Chapter::Residence, :type => :model do
  it "has a valid factory" do
    FactoryGirl.create(:chapter_residence).should be_valid
  end
  
  it "should be invalid without a name" do
    FactoryGirl.build(:chapter_residence, name: nil).should_not be_valid
  end
  
  it "should be invalid without a unique name" do
    FactoryGirl.create(:chapter_residence, name: "test_name").should be_valid
    FactoryGirl.build(:chapter_residence, name: "test_name").should_not be_valid
  end
end
