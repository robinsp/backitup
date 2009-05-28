require File.dirname(__FILE__) + '/spec_helper'

describe BackItUp::FileList do 
  
  it "should add files passed to initialize to files attribute" do 
    expected_files = %w{one two three}
    list = BackItUp::FileList.new(expected_files, [] )
    list.files.should == expected_files
  end
  
  it "should find all files in dirs passed to initilizer and add to files attribute" do 
    dirs = %w{dir_one dir_two dir_three}
    Find.expects(:find).times(3).with { |d| dirs.include? d }.yields("one").then.yields("two").then.yields("three")
    File.expects(:directory?).times(3).returns(false)
    
    list = BackItUp::FileList.new([], dirs)
    
    list.files.should == %w{one two three}
  end
  
end