$LOAD_PATH.unshift File.dirname(__FILE__) + "/../lib"
require 'webify'

Webify::Builder.build("--options")
describe Webify::Builder, ".build" do
  
end