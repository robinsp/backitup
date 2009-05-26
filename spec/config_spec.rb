require File.dirname(__FILE__) + '/spec_helper'

describe BackItUp::Config do 

  it "should eval the file content" do 
    file = mock('mock-file')
    file.expects(:gets).twice.returns("file 'string'", nil)
    
    BackItUp::Config.any_instance.expects(:file).with("string")
    
    BackItUp::Config.new(file)
    
  end
  
  describe "backup()" do 
    it "should yield to block"
  end
  
  describe "file()" do 
    it "should warn if file doesn't exist"
    it "should check if argument is directory"
  end

  
end