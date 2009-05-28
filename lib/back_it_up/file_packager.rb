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
      Zip::ZipFile.open(target_filename, Zip::ZipFile::CREATE) do |zip|
        @config.each_file { |filename| zip.add( zip_entry_name(filename), filename ) } 
      end
      
      @produced_file = target_filename
    end
    
    protected 
    def target_filename
      @target_filename ||= @config.dest_filename + "_#{timestamp}" + ".zip"
    end
    
    private 
    def zip_entry_name(filename)
      zip_entry_prefix + replace_win_drive_letter_in(filename)
    end
    
    def replace_win_drive_letter_in(filename)
      filename.gsub(/^(.):/, '/\1_drive')
    end
    
    def zip_entry_prefix
      @prefix ||= File.basename(target_filename, ".zip")
    end
    
    def timestamp
      Time.now.strftime("%Y%m%d_%H%M%S")
    end
  end
end