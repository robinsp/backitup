require 'net/ftp'

module BackItUp
  class Ftp
    def initialize(options)
      raise "No options" if options == nil || options.empty?
      @options = options
    end
    
    def transfer(filename)
      Net::FTP.open(@options[:host]) do |ftp|
        ftp.login(@options[:user], @options[:passwd] )
        ftp.chdir(@options[:remote_dir]) if @options[:remote_dir]
        ftp.putbinaryfile(filename)
      end
    end
  end  
end
