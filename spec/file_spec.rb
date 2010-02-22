$LOAD_PATH.unshift File.dirname(__FILE__) + "/../lib"
require 'webify'

describe Webify::File, '.new with block' do
  before(:each) do
    @mock_file = mock(File, {:close => nil})
    File.stub!(:new).and_return(@mock_file)
  end
  
  it "should not return an error" do
    lambda {
      Webify::File.new("fake.file", "w") {hello = "asdf"}
    }.should_not raise_exception
  end
  
  it "should call the block" do
    block_called = false
    
    Webify::File.new("fake.file", "w") do
      block_called = true
    end
    
    block_called.should be_true
  end
end