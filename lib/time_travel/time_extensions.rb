require 'time'

module TimeTravel
  module TimeExtensions
  
    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        class << self
          alias_method :immutable_now, :now
          alias_method :now, :mutable_now
        end
      end
      base.now = nil
    end
  
    def closest_second
      Time.gm(year, month, day, hour, min, sec)
    end

    module ClassMethods

      @@now = nil

      def now=(time)
        if time.instance_of?(String)
          if Time.respond_to?(:zone) && Time.zone
            time = Time.zone.parse(time).utc
          else
            time = Time.parse(time)
          end
        end
        @@now = time
      end

      def mutable_now #:nodoc:
        @@now || immutable_now
      end
    
    end
  
  end
end
