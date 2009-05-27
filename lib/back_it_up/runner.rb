module BackItUp
  class Runner
    def initialize(filename)
      raise "Couldn't find file #{filename}" unless File.exists?(filename)
      
      file = File.open(filename) 
      config = Config.new(file)
      puts "Wrote backup to: #{ FilePackager.new(config).package }"
    end
  end
end
