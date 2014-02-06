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
    
    def self.get_on_meal_plan
      brothers = []
      BrothersDke.select("uname, p_class, meal_plan").where(meal_plan: 1).each do | bro |
        name = BrothersPersonal.find_by(uname: bro.uname).full_name
        brothers << {uname: bro.uname, name: name, p_class: bro.p_class}
      end
      brothers.sort_by!{ |a| [a[:p_class], a[:name]]}
      return brothers
    end
    
    def self.add_past_pos(uname, position, start, finish)
      content =  "#{position} (#{start.strftime('%b %-d, %Y')} - #{finish.strftime('%b %-d, %Y')})"
      puts content
      brother = BrothersDke.find_by(uname: uname)
      tmp = brother.past_pos.split(", ")
      tmp << content
      brother.past_pos = tmp.join(", ")
      puts brother.past_pos
      brother.save
    end
end
