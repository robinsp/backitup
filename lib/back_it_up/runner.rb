module BackItUp
  class Runner
    def initialize(filename)
      raise "Couldn't find file #{filename}" unless File.exists?(filename)
      
      file = File.open(filename) 
      Config.new(file)
    
    end
  end
end
