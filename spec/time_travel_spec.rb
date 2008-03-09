$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require 'time_travel'
require 'time'

describe TimeTravel, "assigning to Time.now" do

  before do
    @future = Time.parse("1 April 2020")
  end

  it "should set the time" do
    Time.now = @future
    Time.now.should == @future
  end
  
  it "should return time to system time assigning nil" do
    Time.now = @future
    Time.now = nil
    Time.now.should_not be_nil
    Time.now.should_not == @future
  end
  
  it "should accept a string" do
    Time.now = "1 April 2020"
    Time.now.should == Time.parse("1 April 2020")
  end
  
  after do
    Time.now = nil
  end
  
end

describe TimeTravel, "at_time method" do
  
  before do
    @future = Time.parse("1 April 2020")
  end
  
  it "should change the time within the block" do
    at_time(@future) do
      Time.now.should == @future
    end
  end
  
  it "should restore the system time after the block" do
    at_time(@future) do
    end
    Time.now.should_not == @future
  end
  
  it "should restore the system time after an exception" do
    begin
      at_time(@future) do
        raise "Uh oh"
      end
    rescue
    end
    Time.now.should_not == @future
  end
  
end
