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

      def now=(value)
        @@now = value.respond_to?(:parse_to_time) ? value.parse_to_time : value
      end

      def mutable_now #:nodoc:
        @@now || immutable_now
      end
    
    end
  
  end
end
