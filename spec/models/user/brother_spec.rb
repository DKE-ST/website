require 'rails_helper'

RSpec.describe User::Brother, :type => :model do
  it "has a valid factory" do
    FactoryGirl.create(:user_brother).should be_valid
  end
  
  it "should not be valid without first_name" do 
    FactoryGirl.build(:user_brother, first_name: nil).should_not be_valid
  end
  
  it "should not be valid without last_name" do 
    FactoryGirl.build(:user_brother, last_name: nil).should_not be_valid
  end
  
  it "should be valid with no phone number" do 
    FactoryGirl.build(:user_brother, phone: "").should be_valid
  end
  
  it "should not be valid with non-digits in phone number" do 
    FactoryGirl.build(:user_brother, phone: "test").should_not be_valid
  end
  
  it "should not be valid without dke_info.p_class" do 
    dke_info = FactoryGirl.build(:user_brother_dke_info, p_class: nil)
    FactoryGirl.build(:user_brother, dke_info: dke_info).should_not be_valid
  end
  
  it "should not be valid without mit_info.year" do
    mit_info = FactoryGirl.build(:user_brother_mit_info, year: nil)
    FactoryGirl.build(:user_brother, mit_info: mit_info).should_not be_valid
  end
  
  it "should return first + last for full_name" do 
    t = FactoryGirl.create(:user_brother)
    t.full_name.should == "#{t.first_name} #{t.last_name}"
  end
  
end
