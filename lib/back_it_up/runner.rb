module BackItUp
  class Runner
    def initialize(filename)
      raise "Couldn't find file #{filename}" unless File.exists?(filename)
      
      file = File.open(filename) 
      config = Config.new(file)
      packaged_filename = FilePackager.new(config).package
      puts "Wrote backup to: #{ packaged_filename }"
      
      BackItUp::Ftp.new(config.ftp_options).transfer(packaged_filename) if config.ftp_options
      
    end
  end
end
