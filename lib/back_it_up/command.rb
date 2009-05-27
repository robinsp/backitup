require 'back_it_up'

module BackItUp
  class Command
    def self.run!(args=ARGV)
      filename = args.shift      
      if filename == nil || filename == ""
        usage
      else 
        BackItUp::Runner.new(filename)
      end
      
    end
    
    def self.usage
      puts "Usage: backitup config-file"
    end
  end  
end

BackItUp::Command.run!