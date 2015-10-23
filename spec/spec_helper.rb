$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'capistrano/all'
require 'capistrano/setup'
load 'capistrano_deploy_stubs.rake'
require 'release-conductor'
require 'rspec'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir['#{File.dirname(__FILE__)}/support/**/*.rb'].each {|f| require f}

RSpec.configure do |config|
  config.order = 'random'
end
