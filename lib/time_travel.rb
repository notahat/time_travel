require 'time_travel/time_extensions'
require 'time_travel/string_extensions'
require 'time_travel/date_extensions'

Time.send(:include, TimeTravel::TimeExtensions)
String.send(:include, TimeTravel::StringExtensions)
Date.send(:include, TimeTravel::DateExtensions)

def at_time(time)
  Time.now = time
  begin
    yield Time.now
  ensure
    Time.now = nil
  end
end
