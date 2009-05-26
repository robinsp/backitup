require File.dirname(__FILE__) + '/spec_helper'

describe BackItUp::Runner do 

  it "should require valid file name to initialize" do 
    name_of_invalid_file = "invalidfile.text"
    lambda {BackItUp::Runner.new(name_of_invalid_file)}.should raise_error("Couldn't find file #{name_of_invalid_file}")

    name_of_valid_file = "spec/test-config.backitup"
    lambda {BackItUp::Runner.new(name_of_valid_file)}.should_not raise_error
  end
  
  it "should create Config with file handle" do 
    File.stubs(:exists?).returns(true)
    
    filename = "a-file-name"
    file = mock('fake file handle')
    File.expects(:open).with(filename).returns(file)
    BackItUp::Config.expects(:new).with( file )
    
    BackItUp::Runner.new(filename)
    
  end
  
end