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
      dst_filename = @config.dest_filename
      
      Zip::ZipFile.open(dst_filename, Zip::ZipFile::CREATE) do |zip|
        @config.files.each do |filename|
          zip.add(File.basename(filename), File.dirname(filename) )
        end
      end
      
      @produced_file = dst_filename
    end
  end
end