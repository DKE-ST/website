require 'rails_helper'

RSpec.describe CurrentUser, :type => :model do
  before :all do
    FactoryGirl.create(:user, uname: "alum", group: "dkealum", chicken: "")
    FactoryGirl.create(:user, uname: "active", group: "dkeactive", chicken: "brochicken")
    FactoryGirl.create(:user, uname: "pledge", group: "dkepledge", chicken: "broporn")
    FactoryGirl.create(:user, uname: "affil", group: "dkeaffil", chicken: "")
  end
  
  after :all do
    User.destroy_all
  end
  
  it "should initialize an empty user if username is not found" do
    CurrentUser.find_by(uname: "dne").should_not == nil
  end
  
  describe "valid_user?" do
    it "should return true if logged in" do
      CurrentUser.find_by(uname: "alum").valid_user?.should be true
    end
    
    it "should return false if not logged in" do
      CurrentUser.find_by(uname: "dne").valid_user?.should be false
    end
  end
  
  describe "group?" do
    it "(dkeaffil) should return true when group >= dkeallif" do
      CurrentUser.find_by(uname: "alum").group?("dkeaffil").should be true
      CurrentUser.find_by(uname: "active").group?("dkeaffil").should be true
      CurrentUser.find_by(uname: "pledge").group?("dkeaffil").should be true
      CurrentUser.find_by(uname: "affil").group?("dkeaffil").should be true
    end
    it "(dkepledge) should return true when group >= dkepledge" do
      CurrentUser.find_by(uname: "alum").group?("dkepledge").should be true
      CurrentUser.find_by(uname: "active").group?("dkepledge").should be true
      CurrentUser.find_by(uname: "pledge").group?("dkepledge").should be true
      CurrentUser.find_by(uname: "affil").group?("dkepledge").should_not be true
    end
    it "(dkebro) should return true when group >= dkebro" do
      CurrentUser.find_by(uname: "alum").group?("dkebro").should be true
      CurrentUser.find_by(uname: "active").group?("dkebro").should be true
      CurrentUser.find_by(uname: "pledge").group?("dkebro").should_not be true
      CurrentUser.find_by(uname: "affil").group?("dkebro").should_not be true
    end
  end
  
  describe "admin?" do
    it "(broporn) should return true when chicken >= broporn" do
      CurrentUser.find_by(uname: "active").admin?("broporn").should be true
      CurrentUser.find_by(uname: "pledge").admin?("broporn").should be true
      CurrentUser.find_by(uname: "affil").admin?("broporn").should_not be true
    end
    
    it "(brochicken) should return true when chicken >= brochicken" do
      CurrentUser.find_by(uname: "active").admin?("brochicken").should be true
      CurrentUser.find_by(uname: "pledge").admin?("brochicken").should_not be true
      CurrentUser.find_by(uname: "affil").admin?("brochicken").should_not be true
    end
  end
  
  describe "is_brother?" do
    before :all do
      @brother = FactoryGirl.create(:user_brother, user_id: User.find_by(uname: "active").id)
    end
    
    after :all do
      User::Brother.destroy_all
    end
    
    it "should return true when selected brother is associated with user" do
      CurrentUser.find_by(uname: "active").is_brother?(@brother.id).should be true
    end
    it "should return false when selected brother is not associated with user" do
      CurrentUser.find_by(uname: "alum").is_brother?(@brother.id).should_not be true
    end
  end
  
  describe "title?" do
    before :all do
      FactoryGirl.create(:user_brother, user_id: User.find_by(uname: "active").id)
      brother = FactoryGirl.create(:user_brother, user_id: User.find_by(uname: "alum").id)
      @officer = FactoryGirl.create(:chapter_officer, dke_info_id: brother.dke_info.id)
    end
    
    after :all do
      User::Brother.destroy_all
      Chapter::Officer.destroy_all
    end
    
    it "should return true when selected officer is associated with user" do
      CurrentUser.find_by(uname: "alum").officer?(@officer.name).should be true
    end
    
    it "should return false when selected officer is not associated with user" do
      CurrentUser.find_by(uname: "pledge").officer?(@officer.name).should_not be true
    end
    
    it "should return true when user has brochicken access" do
      CurrentUser.find_by(uname: "active").officer?(@officer.name).should be true
    end
  end
  
end
