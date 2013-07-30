require 'spec_helper'

describe BrothersPersonal do
  before do
    @user = BrothersPersonal.new(uname: 'reynolds' , first_name: "Malcolm" , last_name: "Reynolds")
    @user.phone = "1112223333"
  end
  
  subject { @user }
  
  it { should respond_to(:id) }
  it { should respond_to(:uname) }
  it { should respond_to(:last_name) }
  it { should respond_to(:first_name) }
  it { should respond_to(:phone) }
  it { should respond_to(:bio) }
  it { should respond_to(:activities) }
  it { should respond_to(:hobbies) }
  it { should respond_to(:pro_team) }
  it { should respond_to(:college_team) }
  it { should respond_to(:movie) }
  it { should respond_to(:quote) }
  it { should respond_to(:hometown) }
  
  it { should be_valid }
  
  describe "when username is not present" do
    before { @user.uname = " " }
    it { should_not be_valid }
  end
  
  describe "when username is too long" do
    before { @user.uname = "a" * 9 }
    it { should_not be_valid }
  end
  
  describe "when first name is not present" do
    before { @user.first_name = " " }
    it { should_not be_valid }
  end
  
  describe "when last name is not present" do
    before { @user.last_name = " " }
    it { should_not be_valid }
  end
  
  describe "when phone number is invalid" do
    before { @user.phone = "123456a789" }
    it { should_not be_valid }
  end
  
end
