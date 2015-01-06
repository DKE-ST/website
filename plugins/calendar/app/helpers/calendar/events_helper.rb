module Calendar
  module EventsHelper
    
    def formatDateTime(datetime)
      if datetime.nil?
        return ""
      else
        return  datetime.strftime("%Y/%m/%d %H:%M")
      end
    end
    
  end
end
