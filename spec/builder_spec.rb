$LOAD_PATH.unshift File.dirname(__FILE__) + "/../lib"
require 'webify'

describe Webify::Builder, "attributes" do
  before(:each) do
    @builder = Webify::Builder.new
  end
  
  it "should allow source_dir to be set" do
    @builder.source_dir = "asdf"
    @builder.source_dir.should == "asdf"
  end
  
  it "should allow output_dir to be set" do
    @builder.output_dir = "asdf"
    @builder.output_dir.should == "asdf"
  end
end

describe Webify::Builder, ".new" do
  it "should set source_dir if specified" do
    @builder = Webify::Builder.new("directory")
    @builder.source_dir.should == "directory"
  end
  
  it "should set source_dir to ./ if not specified" do
    @builder = Webify::Builder.new
    @builder.source_dir.should == "./"
  end
end

describe Webify::Builder, "#source_paths" do  
  before(:each) do
    @builder = Webify::Builder.new
  end
  
  it "should default to current directory if no directory specified" do
    @builder.source_dir = nil
    Dir.should_receive("[]").with("./**/*.md").and_return([])
  end
  
  it "should properly glob with a specified directory" do
    @builder.source_dir = "/directory"
    Dir.should_receive("[]").with("/directory/**/*.md").and_return([])
  end
  
  it "should return result of Dir[]" do
    Dir.stub!(:[]).and_return(["asdf"])
    @builder.source_paths.should == ["asdf"]
  end
  
  after(:each) do
    @builder.source_paths
  end
end

describe Webify::Builder, "#output_path_for" do
  before(:each) do
    @builder = Webify::Builder.new
    @builder.source_dir = "./"
    @builder.output_dir = "../output/"
  end
  
  it "should return file with proper path and extension" do
    @builder.output_path_for(File.join("./", "directory/" "asdf.md")).should == File.join("../output/", "directory/", "asdf.htm")
  end
end