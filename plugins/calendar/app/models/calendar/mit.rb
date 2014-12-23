module Calendar
  class Mit
    def self.get_registrar_events(params = {})
      start_time = (params.include? :start)?Date.parse(params[:start]):0
      end_time = (params.include? :end)?Date.parse(params[:end]):Float::INFINITY
      events = []
      page = Nokogiri.HTML(open("http://web.mit.edu/registrar/calendar/"))
      r1 = page.css("table.calendar")
      month = ""
      date = ""
      r1.css("tr").each do | row |
        month = row.css("td.calmonth").css("p")[0].text if row.css("td.calmonth").length > 0
        date = row.css("td.caldate")[0].text if row.css("td.caldate").length > 0
        #day = row.css("td.calday")[0].text if row.css("td.calday").length > 0
        if row.css("td.caldesc").css("p").length > 0
          desc = row.css("td.caldesc").css("p")[0].text
          dt = Date.parse("#{month} #{date}")
          if dt >= start_time && dt <= end_time
            events << {start: dt.to_default_s, allDay: true, title: desc}
          end
        end
      end
      return events
    end
    
  end
end
