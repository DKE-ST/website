require 'spec_helper'

describe BrothersDke do
  
    before do
    @user = BrothersDke.new(uname: "reynolds" , p_class:"2500")
  end
  
  subject { @user }
  
  it { should respond_to(:id) }
  it { should respond_to(:uname) }
  it { should respond_to(:pname) }
  it { should respond_to(:project) }
  it { should respond_to(:big) }
  it { should respond_to(:littles) }
  it { should respond_to(:cur_pos) }
  it { should respond_to(:past_pos) }
  it { should respond_to(:residence) }
  it { should respond_to(:p_class) }
  
  it { should be_valid }
  
  describe "when username is not present" do
    before { @user.uname = " " }
    it { should_not be_valid }
  end
  
  describe "when username is too long" do
    before { @user.uname = "a" * 9 }
    it { should_not be_valid }
  end
  
  describe "when p_class is not present" do
    before {@user.p_class =""}
    it { should_not be_valid }
  end
  
  describe "when p_class is contains non-numbers" do
    before {@user.p_class ="201a"}
    it { should_not be_valid }
  end
  
end
