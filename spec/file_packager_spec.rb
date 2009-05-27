require File.dirname(__FILE__) + '/spec_helper'

describe BackItUp::FilePackager do 
  describe "constructor" do 
    it "should fail if initialized with nil config" do 
      lambda { BackItUp::FilePackager.new(nil) }.should raise_error(BackItUp::FilePackager::INVALID_CONFIG_MSG )
    end
    
    it "should fail if initialized without config" do 
      lambda { BackItUp::FilePackager.new("a string") }.should raise_error(BackItUp::FilePackager::INVALID_CONFIG_MSG )
    end  
  end
  
  describe "package()" do 
    before do 
      @first_file_to_add = "/etc/passwd"
      @second_file_to_add = "/etc/httpd/apache.cfg"
      
      @configured_dst_filename = "a-file-name"
      mock_config = mock
      mock_config.stubs(:is_a? => true)
      mock_config.stubs(:dest_filename).returns(@configured_dst_filename)
      mock_config.stubs(:files).returns([@first_file_to_add, @second_file_to_add])

      @mock_zip = mock("mock-zip")
      @mock_zip.stubs(:add)
      Zip::ZipFile.stubs(:open).yields(@mock_zip)
      
      @packager = BackItUp::FilePackager.new(mock_config)
      
    end
    
    it "should use the destination_file setting from config" do 
      @packager.package.should =~ /^#{@configured_dst_filename}/
    end
    
    it "should produce a file name with timestamp and zip suffix"
    
    it "should return name of produced file" do 
      @packager.package.should_not be_nil
    end
    
    it "should set the produced_file attribute" do 
      @packager.package.should == @packager.produced_file
    end
    
    it "should create the file package" do 
      Zip::ZipFile.expects(:open).with() do  |name, type| 
        (name =~ /^#{@configured_dst_filename}/ && type == Zip::ZipFile::CREATE) 
      end
      
      @packager.package
    end
    
    it "should add files to the zip" do 
      @mock_zip.expects(:add).with(File.basename(@first_file_to_add), File.dirname(@first_file_to_add) )
      @mock_zip.expects(:add).with(File.basename(@second_file_to_add), File.dirname(@second_file_to_add) )
      @packager.package
    end
  end
end
