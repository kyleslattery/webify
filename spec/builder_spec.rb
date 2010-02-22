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
end

describe Webify::Builder, "#source_files" do  
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
    @builder.source_files.should == ["asdf"]
  end
  
  after(:each) do
    @builder.source_files
  end
end