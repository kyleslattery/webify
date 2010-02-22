module Webify
  class File < ::File
    def self.new(filename, mode="r")
      file = ::File.new(filename, mode)

      if block_given?
        yield(file)
        file.close
      else
        file
      end
    end
  end
end