class NilClass 
  def blank?
    true
  end
end

class String 
  def blank?
    (self == nil || self == "")
  end
end

require 'back_it_up/runner'
require 'back_it_up/config'
require 'back_it_up/file_packager'
require 'back_it_up/file_list'
