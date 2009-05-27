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
    
    # Full path and name of the package file to create.
    # A timestamp will be appended to the filename and the extension is 
    # determined by the packager used.
    #
    #   # Using the zip packager with a destination file setting:
    #   /var/backup/mybackup 
    #
    #   # ...then the final result might be:
    #   /var/backup/mybackup_200900527_053032.zip
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
