require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  
  it "is invalid withour a uname" do
    FactoryGirl.build(:user, uname: nil).should_not be_valid
  end
  
  it "is invalid without a unique uname" do
    FactoryGirl.create(:user, uname: "mal44").should be_valid
    FactoryGirl.build(:user, uname: "mal44").should_not be_valid
  end
  it "is invalid with a uname of more than 8 characters" do
    FactoryGirl.build(:user, uname: "123456789").should_not be_valid
  end
  
  it "is invalid without a password or valid kerbaros" do 
    FactoryGirl.build(:user, password: nil).should_not be_valid
  end
end
