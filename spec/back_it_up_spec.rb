require File.dirname(__FILE__) + '/spec_helper'

describe BackItUp do 

  it "should require valid file name to initialize" do 
    name_of_invalid_file = "invalidfile.text"
    lambda {BackItUp.new(name_of_invalid_file)}.should raise_error("Couldn't find file #{name_of_invalid_file}")

    name_of_valid_file = "spec/test-config.backitup"
    lambda {BackItUp.new(name_of_valid_file)}.should_not raise_error
  end
  
  it "should eval the file contents"
  
  describe "file()" do 
    it "should warn if file doesn't exist"
    it "should check if argument is directory"
  end
  
  
end