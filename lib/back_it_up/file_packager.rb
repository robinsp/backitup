require 'rubygems'
require 'zip/zip'

module BackItUp
  class FilePackager  
    INVALID_CONFIG_MSG = "Invalid config"
    attr_reader :produced_file
    
    def initialize(config) 
      raise INVALID_CONFIG_MSG if config == nil || !config.is_a?(Config)
      @config = config
    end
    
    def package
      target_filename = create_target_filename
      
      prefix = File.basename(target_filename, ".zip")
      
      Zip::ZipFile.open(target_filename, Zip::ZipFile::CREATE) do |zip|
        
        @config.each_file do |filename|
          zip_entry = "#{prefix}#{filename.gsub(/^(.):/, '/\1_drive')}"
          zip.add(zip_entry, filename)
        end
        
      end
      
      @produced_file = target_filename
    end
    
    protected 
    def create_target_filename
      @config.dest_filename + "_#{timestamp}" + ".zip"
    end
    
    private 
    def timestamp
      Time.now.strftime("%Y%m%d_%H%M%S")
    end
  end
end