module BackItUp
  class Config
    def initialize(file_handle)
      file_content = ""
    
      while l = file_handle.gets do 
        file_content << l
      end
      
      eval(file_content)
    end
    
    def backup
      #yield
    end
  end  
end
