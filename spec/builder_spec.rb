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

describe Webify::Builder, "#build" do
  before(:each) do
    @builder = Webify::Builder.new
    @builder.stub!(:process_source).and_yield("content")
    
    @rdiscount_mock = mock(RDiscount, :to_html => "html")
    RDiscount.stub!(:new).and_return(@rdiscount_mock)
  end
  
  it "should call process_source" do
    @builder.should_receive(:process_source)
  end
  
  it "should parse source with RDiscount" do
    RDiscount.should_receive(:new).with("content").and_return(@rdiscount_mock)
  end
  
  # TODO: This really should test to see if the block returns the value of
  # to_html, but I don't know if that's possible.
  it "should call to_html on RDiscount" do
    @rdiscount_mock.should_receive(:to_html)
  end
  
  after(:each) do
    @builder.build
  end
end

describe Webify::Builder, "#process_source" do
  before(:each) do
    @builder = Webify::Builder.new
    @builder.stub!(:source_paths).and_return(["a", "b"])
    @builder.stub!(:output_path_for).and_return("abc")
    
    @file_mock = mock(File)
    @file_mock.stub!(:puts)
    
    File.stub!(:read).and_return("asdf", "fdsa")
    
    Webify::File.stub(:new).and_yield(@file_mock)
  end
  
  it "should require a block" do
    lambda {@builder.process_source}.should raise_exception(LocalJumpError)
  end
  
  it "should read the contents of each source_path" do
    File.should_receive(:read).with("a").once
    File.should_receive(:read).with("b").once
    @builder.process_source {}
  end
  
  it "should yield the content of each source file" do
    content = []
    @builder.process_source {|a| content << a}
    content.should == ["asdf", "fdsa"]
  end
  
  it "should write to file specified by output_file_for" do
    Webify::File.should_receive(:new).with("abc", "w").twice
    @builder.process_source {}
  end
  
  it "should write return value from block to the output file" do
    @file_mock.should_receive(:puts).with("sdf").twice
    @builder.process_source {|a| "sdf"}
  end
  
  it "should puts source if nothing is returned from block" do
    @file_mock.should_receive(:puts).with("asdf")
    @file_mock.should_receive(:puts).with("fdsa")
    @builder.process_source {}
  end
end