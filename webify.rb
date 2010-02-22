require 'rubygems'
require 'rdiscount'
require 'erb'

`mkdir -p output`

class BetterFile < File
  def self.new(filename, mode="r")
    file = File.new(filename, mode)
    
    if block_given?
      yield(file)
      file.close
    else
      file
    end
  end
end

template = ERB.new(File.read('template.erb'))

Dir['example/**/*.md'].each do |path|
  contents = File.read(path)
  
  newpath = path.gsub('example/', 'output/').gsub('.md', '.html')
  
  BetterFile.new(newpath, 'w') do |f|
    title = File.basename(path, '.md')
    body = RDiscount.new(contents).to_html
    
    f.write(template.result(binding))
  end
end