require File.dirname(__FILE__) + '/spec_helper'

describe BackItUp::Runner do 

  it "should require valid file name to initialize" do 
    name_of_invalid_file = "invalidfile.text"
    lambda {BackItUp::Runner.new(name_of_invalid_file)}.should raise_error("Couldn't find file #{name_of_invalid_file}")
  end

  describe "with valid file" do 
    before do 
      @package_result_filename = "package_result_filename"
      
      File.stubs(:exists?).returns(true)
      @filename = "a-file-name"
      
      @file = mock('fake file handle')
      File.stubs(:open).with(@filename).returns(@file)
      
      @mock_config = mock('mock-config')
      BackItUp::Config.stubs(:new).returns(@mock_config)
      
      @mock_packager
      @mock_packager.stubs(:package).returns(@package_result_filename)
      BackItUp::FilePackager.stubs(:new).returns(@mock_packager)
      
      
    end
    it "should create Config with file handle" do 
      BackItUp::Config.expects(:new).with( @file ).returns(@mock_config)
      BackItUp::Runner.new(@filename)
    end
    
    it "should create Packager with Config" do 
      BackItUp::FilePackager.expects(:new).with(@mock_config)
      BackItUp::Runner.new(@filename)
    end
    
    it "should start packaging" do 
      @mock_packager.expects(:package)
      BackItUp::Runner.new(@filename)
    end
    
    it "should print name of packaged file" do 
      BackItUp::Runner.any_instance.expects(:puts).with {|s| s =~ /#{@package_result_filename}/ }
      BackItUp::Runner.new(@filename)
    end
    
  end
  
end