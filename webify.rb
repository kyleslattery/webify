require 'rubygems'
require 'rdiscount'
require 'erb'
require 'lib/webify/file'

`mkdir -p output`

template = ERB.new(File.read('template.erb'))

Dir['example/**/*.md'].each do |path|
  contents = File.read(path)
  
  newpath = path.gsub('example/', 'output/').gsub('.md', '.html')
  
  Webify::File.new(newpath, 'w') do |f|
    puts 'hi'
    title = File.basename(path, '.md')
    body = RDiscount.new(contents).to_html
    
    f.write(template.result(binding))
  end
end