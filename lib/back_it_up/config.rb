module BackItUp
  class Config
    attr_reader :files, :dirs, :dest_filename
    
    def initialize(file_handle)
      file_content = ""
    
      while l = file_handle.gets do 
        file_content << l
      end
      
      eval(file_content)
      
      @files = []      
      @dirs = []
    end
    
    def backup
      yield
    end
    
    def destination_file(filename) 
      raise "Invalid destination file." if File.directory?(filename)
      @dest_filename = filename
    end
    
    def file(filename = nil)

      unless (filename  == "" || filename == nil)
        if File.exists?(filename)
          if File.directory? filename
            @dirs << filename
          else
            @files << filename
          end
              
        else 
          puts "WARNING: File #{filename} could not be found"    
        end
      end
      
    end
    
    alias_method :dir, :file
  end  
end
