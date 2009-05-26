class BackItUp
  def initialize(filename)
    raise "Couldn't find file #{filename}" unless File.exists?(filename)
  end
end