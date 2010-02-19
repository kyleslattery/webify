require "../lib/webify"

describe Webify::Builder, ".new" do
  it "should require the directory argument to be passed" do
    lambda {Webify::Builder.new()}.should raise_exception(ArgumentError)
  end
end