
$: << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'back_it_up'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
