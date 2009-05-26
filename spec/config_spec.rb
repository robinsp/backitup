require File.dirname(__FILE__) + '/spec_helper'

describe BackItUp::Config do 

  it "should eval the file content" do 
    file = mock('mock-file')
    file.expects(:gets).twice.returns("file 'string'", nil)
    
    BackItUp::Config.any_instance.expects(:file).with("string")
    BackItUp::Config.new(file)
  end
  
  it "should be able to handle our test config" do 
    test_file = File.dirname(__FILE__) + "/test-config.backitup"
    
    BackItUp::Config.new(File.open(test_file))
  end
  
  describe "" do 
    before do 
      mock_file = mock('mock-file')
      mock_file.stubs(:gets).returns(nil)
      @config = BackItUp::Config.new(mock_file)
    end
    
    it "should have empty array of files by default" do 
      @config.files.should == []
    end
    
    it "should have empty array of dirs by default" do 
      @config.dirs.should == []
    end
    
    describe "destination_file()" do 
      
      it "should save the filename to dest_filename attribute" do 
        filename = File.expand_path(File.dirname(__FILE__) + "backup") 
        @config.destination_file(filename)
        @config.dest_filename.should == filename
      end
      
      it "should fail if filename is an existing directory" do 
        filename = File.expand_path(File.dirname(__FILE__) )
        lambda { @config.destination_file(filename) }.should raise_error("Invalid destination file.")
      end
    end
      
    describe "backup()" do 
      it "should yield to block" do 
        test_value = false
        
        @config.backup do 
          test_value = true
        end
        
        test_value.should be_true
      end
    end
    
    describe "file()" do 
      before do 
        @valid_file = File.expand_path(File.dirname(__FILE__) + '/test-config.backitup')
      end

      it "should warn if file doesn't exist" do 
        file_name = "should-not-exist"
        BackItUp::Config.any_instance.expects(:puts).with("WARNING: File should-not-exist could not be found")
        @config.file(file_name)
      end
      
      it "should not add non-existning files to files attribute" do 
        file_name = "should-not-exist"
        @config.file(file_name)
        @config.files.should be_empty
      end
      
      it "should allow nil file name argument" do 
        @config.file
      end
      
      it "should check if file exists" do 
        File.expects(:exists?).with("filename").returns(false)
        @config.file("filename")
      end
      
      it "should add the file to the files array" do 
        @config.file(@valid_file)
        @config.files.pop.should == @valid_file
      end
      
      it "should check if file argument is directory" do 
        File.expects(:directory?).returns(false)        
        @config.file(@valid_file)
      end
      
      it "should add directories to dirs array" do 
        File.stubs(:directory?).returns(true)
        @config.file(@valid_file)
        @config.dirs.pop.should == @valid_file
      end
    end
  end
  
end