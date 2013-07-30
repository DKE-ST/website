require 'spec_helper'

describe BrothersMit do
  before do
    @user = BrothersMit.new(uname: "reynolds" , year:"2500")
  end
  
  subject { @user }
  
  it { should respond_to(:id) }
  it { should respond_to(:uname) }
  it { should respond_to(:majors) }
  it { should respond_to(:minors) }
  it { should respond_to(:concentration) }
  it { should respond_to(:extracurriculars) }
  it { should respond_to(:interests) }
  it { should respond_to(:urops) }
  it { should respond_to(:internships) }
  it { should respond_to(:fav_classes) }
  it { should respond_to(:year) }
  
  it { should be_valid }
  
  describe "when username is not present" do
    before { @user.uname = " " }
    it { should_not be_valid }
  end
  
  describe "when username is too long" do
    before { @user.uname = "a" * 9 }
    it { should_not be_valid }
  end
  
  describe "when year is not present" do
    before {@user.year =""}
    it { should_not be_valid }
  end
  
  describe "when year is contains non-numbers" do
    before {@user.year ="201a"}
    it { should_not be_valid }
  end
end
