require 'spec'
require 'spec/rake/spectask'
require 'echoe'

Echoe.new('backitup', '0.0.2') do |p|
  p.description    = "Simple backup tool"
  p.url            = "http://github.com/robinsp/backitup"
  p.author         = "Robin Spainhour"
  p.email          = "robin@robinspainhour.com"
  p.ignore_pattern = ["tmp/*"]
  p.dependencies = ["rubyzip"]
end

Spec::Rake::SpecTask.new do |t|
  t.warning = true
end