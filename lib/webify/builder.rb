require "rubygems"
require "rdiscount"

module Webify
  class Builder
    attr_accessor :source_dir, :output_dir
    
    def initialize(source=nil, output=nil)
      @source_dir = source || "./"
      @output_dir = output || "./webify/"
    end
    
    def build
      process_source do |source|
        RDiscount.new(source).to_html
      end
    end
    
    def source_paths
      dir  = @source_dir.nil? ? "./" : @source_dir
      glob = File.join(dir, "**", "*.md")
      
      Dir[glob]
    end
    
    def output_path_for(source_path)
      source_path.gsub(@source_dir, @output_dir).gsub(/\.md$/, ".htm")
    end
    
    def process_source(&block)
      source_paths.each do |path|
        Webify::File.new(output_path_for(path), "w") do |file|
          source = ::File.read(path)
          output = yield(source) || source

          file.puts output
        end
      end
    end
  end
end