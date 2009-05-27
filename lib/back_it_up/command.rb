require 'back_it_up'

module BackItUp
  class Command
    def self.run!(args=ARGV)
      puts "Seems to be working"
    end
  end  
end

BackItUp::Command.run!