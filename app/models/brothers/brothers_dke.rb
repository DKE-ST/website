class BrothersDke < ActiveRecord::Base
    self.table_name = 'brothers_dke'
    #id: integer
    #uname: string
    validates :uname, presence: true, uniqueness: { case_sensitive: false } , length: { maximum: 8 }
    #pname: text
    #project: text
    #big: text
    #littles: text
    #past_pos: text
    #residence: text
    #p_class: integer
    VALID_YEAR = /[\d]{4}/
    validates :p_class, presence: true, format: {with: VALID_YEAR}
    
    def cur_pos
      return Positions.get_current(self.uname)
    end
    
    def add_past_pos(position)
      if position == "kappa"
        time_stamp = "#{Date.current.year-2}-#{Date.current.year}"
      elsif position =~ /(beta|sigma)/
        time_stamp = "#{Date.current.year-1}-#{Date.current.year}"
      else
        season = (Date.current.month>7 && Date.current.month < 12)?"Spring":"Fall"
        time_stamp = "#{season} #{Date.current.year}"
      end
      tmp = self.past_pos.split(", ")
      tmp << "#{position.capitalize} (#{time_stamp})"
      tmp.sort!
      self.past_pos = tmp.join(", ")
      self.save
    end
end
