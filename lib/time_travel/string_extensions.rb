module TimeTravel
  module StringExtensions
    
    def parse_to_time
      if Time.respond_to?(:zone) && Time.zone
        Time.zone.parse(self).utc
      else
        Time.parse(self)
      end
    end
    
  end
end
