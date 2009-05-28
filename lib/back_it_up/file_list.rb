require 'find'

module BackItUp
  class FileList
    attr_reader :files
    
    def initialize(files, dirs)
      @files = []
      files.each {|f| @files << f }
      
      dirs.each do |d| 
        Find.find(d) do |f|
          next if File.directory?(f)
          @files << f
        end
      end
    end
  end
end