require File.dirname(__FILE__) + '/spec_helper'

describe BackItUp::Ftp do 
  before do 
    @user = "username"
    @passwd = "password"
    @host = "hostname"
    
    @options = {:user => @user, :host => @host, :passwd => @passwd}
  end
  
  describe "constructor" do 
    it "should require options" do 
      lambda {BackItUp::Ftp.new(nil) }.should raise_error
      lambda {BackItUp::Ftp.new({}) }.should raise_error
      lambda {BackItUp::Ftp.new(@options) }.should_not raise_error
    end
  end
  
  describe "transfer()" do 
    before do 
      @filename = "thefilename"
      @mock_ftp = stub("mock-ftp", :login => "", :putbinary => "")
      
      Net::FTP.stubs(:open).with(@host).yields(@mock_ftp)
      @ftp = BackItUp::Ftp.new(@options)
    end
    
    it "should open host" do 
      Net::FTP.expects(:open).with(@host)
      @ftp.transfer(@filename)
    end
    
    it "should login" do 
      @mock_ftp.expects(:login).with(@user, @passwd)
      @ftp.transfer(@filename)
    end
    
    it "should put binary file" do 
      @mock_ftp.expects(:putbinary).with(@filename)
      @ftp.transfer(@filename)
    end
    
    it "should change directory if option is set" do 
      dirname = "remote-directory"
      @mock_ftp.expects(:chdir).with(dirname)
      ftp = BackItUp::Ftp.new( @options.merge(:remote_dir => dirname) )
      ftp.transfer(@filename)
    end
  end
end
