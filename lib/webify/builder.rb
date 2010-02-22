module Webify
  class Builder
    attr_accessor :source_dir, :output_dir
    
    def initialize(source=nil)
      @source_dir = source || "./"
    end
        
    def source_paths
      dir  = @source_dir.nil? ? "./" : @source_dir
      glob = File.join(dir, "**", "*.md")
      
      Dir[glob]
    end
    
    def output_path_for(source_path)
      source_path.gsub(@source_dir, @output_dir).gsub(/\.md$/, ".htm")
    end
  end
end