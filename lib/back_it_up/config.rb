module BackItUp
  
  # The backup script should look something like this
  #
  #    # sample.backitup
  #    
  #    backup do 
  #    
  #      file '/home/robin/backup.this.file'   
  #    
  #      dir '~/Desktop/drop-in-me-for-backup'
  #      
  #      destination_file "/tmp/backupfile"
  #    end
  #
  # This will backup the file <tt>/home/robin/backup.this.file</tt> and all the files
  # in the <tt>~/Desktop/drop-in-me-for-backup</tt> directory and its sub dirs, and 
  # place them in <tt>/tmp/backupfile_[date]_time.zip</tt>.
  module ScriptDSL 
    INVALID_FTP_ARG_MSG = "Invalid arguments for ftp"

    # After packaging backup set send the file to this server.
    #
    # Options:
    #   <tt>:remote_dir</tt>  Remote directory on FTP host
    #
    def ftp(host, user, passwd, options = {} )
      raise INVALID_FTP_ARG_MSG if host.blank? || user.blank? || passwd.blank?
      
      @ftp_options = options.merge( {:user => user, :host => host, :passwd => passwd } )
    end
    
    # Starts off the backup script. 
    #
    # Usage:
    #
    #   backup do 
    #     # add your files, dirs etc. here...
    #   end
    def backup
      yield
    end
    
    # File or directory name to add to the backup set. The given file name is expanded before 
    # added to the backup set.
    # 
    # It is safer to use single quotes (especially on Windows file systems) as the support
    # for escape sequences is not as great as double-quoted strings.
    #
    #   file '~/importantfile'  # is safer 
    #   file "~/anotherfile"    # ...than this
    #
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
    attr_reader :files, :dirs, :dest_filename, :ftp_options
    
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
