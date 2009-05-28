module BackItUp
  
  module ScriptDSL 
    
    def backup
      yield
    end
    
    def file(filename = nil)
      unless (filename  == "" || filename == nil)
        full_name = File.expand_path(filename)
        
        if File.exists?(full_name)
          if File.directory? full_name
            @dirs << full_name
          else
            @files << full_name
          end
              
        else 
          puts "WARNING: File #{filename} could not be found"    
        end
      end
      
    end
    
    alias_method :dir, :file
    
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
    
  end
  
  
  class Config
    include ScriptDSL
    attr_reader :files, :dirs, :dest_filename
    
    def initialize(file_handle)
      @files = []      
      @dirs = []    
      
      file_content = ""

      while l = file_handle.gets do 
        file_content << l
      end
      
      eval(file_content)
    end
    
    def each_file 
      FileList.new(@files, @dirs).files.each {|filename| yield filename }
    end
  end  
end
