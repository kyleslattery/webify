module Webify
  class Builder
    attr_accessor :source_dir
        
    def source_files
      dir  = @source_dir.nil? ? "./" : @source_dir
      glob = File.join(dir, "**", "*.md")
      
      Dir[glob]
    end
  end
end