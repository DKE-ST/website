require 'rails_helper'

RSpec.describe CurrentUser, :type => :model do
  it "should initialize an empty user if username is not found" do
    CurrentUser.find_by(uname: "dne").should_not == nil
  end
  
end
