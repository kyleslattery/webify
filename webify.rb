require 'rubygems'
require 'rdiscount'

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

Dir['example/**/*.md'].each do |path|
  contents = File.read(path)
  
  newpath = path.gsub('example/', 'output/').gsub('.md', '.html')
  
  BetterFile.new(newpath, 'w') do |f|
    f.write(RDiscount.new(contents).to_html)
  end
end