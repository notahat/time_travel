$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
require 'time_travel'
require 'time'
require 'active_support'

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
  
  it "should accept a date" do
    Time.now = @future.to_date
    Time.now.should == Time.parse("1 April 2020")
  end
  
  context "in the current timezone as set in ActiveSupport" do
    
    before do
      Time.zone = "Perth"
    end
  
    it "should accept a date" do
      Time.now = Date.civil(2020, 7, 1)
      Time.now.should == Time.parse("30 June 2020 4:00 PM UTC")
    end
    
    it "should accept a string" do
      Time.now = "1 July 2020 11:00 AM"
      Time.now.should == Time.parse("1 July 2020 3:00 AM UTC")
    end
    
  end
  
  context "in the current timezone as set in the environment" do
    
    before do
      Time.zone = nil
      ENV['TZ'] = "Australia/Perth"
    end
  
    it "should accept a date" do
      Time.now = Date.civil(2020, 7, 1)
      Time.now.should == Time.parse("30 June 2020 4:00 PM UTC")
    end
  
    it "should accept a string" do
      Time.now = "1 July 2020 11:00 AM"
      Time.now.should == Time.parse("1 July 2020 3:00 AM UTC")
    end
    
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
  
  it "should change the date within the block" do
    at_time(@future.to_date) do
      Date.today.should == @future.to_date
    end
  end
  
  it "should pass the time into the block" do
    at_time(@future) do |time|
      time.should == @future
    end
  end
  
  it "should pass the time into the block being given a date" do
    at_time(@future.to_date) do |time|
      time.should == @future
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

describe TimeTravel, "closest_second method" do
  
  it "should return the time with no microseconds" do
    Time.utc(2020, 4, 1, 9, 0, 0, 500).closest_second.should == Time.utc(2020, 4, 1, 9, 0, 0)
  end
    
end
