require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  
  it "is invalid withour a uname" do
    FactoryGirl.build(:user, uname: nil).should_not be_valid
  end
  
  it "is invalid without a unique uname" do
    FactoryGirl.create(:user, uname: "mal44")
    FactoryGirl.build(:user, uname: "mal44").should_not be_valid
  end
  it "is invalid with a uname of more than 8 characters" do
    FactoryGirl.build(:user, uname: "123456789").should_not be_valid
  end
  
  it "is invalid with a non-unique mit_id" do
    FactoryGirl.create(:user, mit_id: "911234567")
    FactoryGirl.build(:user, mit_id: "911234567").should_not be_valid
  end
  
  it "should create a shadow if password is present when saving" do
    user = FactoryGirl.create(:user)
    user.save
    user.shadow.should be_valid
  end
  
  it "should have a mit_ldap entry for a valid kerberos (time consuming to run)"# do
  #  krb = User::MitLdap.first
  #  user = FactoryGirl.create(:user, uname: krb.uid)
  #  user.mit_ldap.should == krb
  #end
end
