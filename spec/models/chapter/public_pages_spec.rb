require 'rails_helper'

RSpec.describe Chapter::PublicPage, :type => :model do
  it "has a valid factory" do
    FactoryGirl.create(:chapter_public_page).should be_valid
  end
  
  it "should be invalid without a pname" do
    FactoryGirl.build(:chapter_public_page, pname: nil).should_not be_valid
  end
  
  it "should be invalid without a unique pname" do
    FactoryGirl.create(:chapter_public_page, pname: "test_page").should be_valid
    FactoryGirl.build(:chapter_public_page, pname: "test_page").should_not be_valid
  end
  
  it "should be invalid without a title" do
    FactoryGirl.build(:chapter_public_page, title: nil).should_not be_valid
  end
  
  it "should be invalid without content" do
    FactoryGirl.build(:chapter_public_page, content: nil).should_not be_valid
  end
  
  describe "can_edit?" do
    it "should return true for officer who owns page" do
      user = FactoryGirl.create(:user, uname: "river")
      user.brother = FactoryGirl.create(:user_brother)
      position = FactoryGirl.create(:chapter_officer, dke_info_id: user.brother.dke_info.id)
      page = FactoryGirl.create(:chapter_public_page, officer_id: position.id)
      page.can_edit?(CurrentUser.find_by(uname: "river")).should be true
    end
    it "should return true for brochicken" do
      user = FactoryGirl.create(:user, uname: "river", chicken: "brochicken")
      page = FactoryGirl.create(:chapter_public_page)
      page.can_edit?(CurrentUser.find_by(uname: "river")).should be true
    end
    it "should return false " do
      page = FactoryGirl.create(:chapter_public_page)
      page.can_edit?(CurrentUser.find_by(uname: "river")).should_not be true
    end
  end
  
end
