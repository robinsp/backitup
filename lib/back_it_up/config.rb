module BackItUp
  class Config
    attr_reader :files
    
    def initialize(file_handle)
      file_content = ""
    
      while l = file_handle.gets do 
        file_content << l
      end
      
      eval(file_content)
      
      @files = []      
    end
    
    def backup
      yield
    end
    
    def file(filename = nil)

      unless (filename  == "" || filename == nil)
        if File.exists?(filename)
          @files << filename    
        else 
          puts "WARNING: File #{filename} could not be found"    
        end
      end
      
    end
  end  
end
