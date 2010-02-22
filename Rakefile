require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('webify', '0.1.0') do |p|
  p.description              = "Turn a directory of Markdown files into HTML"
  p.url                      = "http://github.com/kyleslattery/webify"
  p.author                   = "Kyle Slattery"
  p.email                    = "kyle@kyleslattery.com"
  p.ignore_pattern           = ["tmp/*", "script/*", "output/*", "example/*"]
  p.development_dependencies = ["rspec"]
  p.runtime_dependencies     = ["rdiscount"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each {|ext| load ext}