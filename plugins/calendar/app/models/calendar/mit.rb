module Calendar
  class Mit
    def self.get_registrar_events
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
          dt = Date.parse("#{month} #{date}").to_default_s
          events << {start: dt, allDay: true, title: desc}
        end
      end
      return events
    end
    
  end
end
