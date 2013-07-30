class BrothersDke < ActiveRecord::Base
    self.table_name = 'brothers_dke'
    #id: integer
    #uname: string
    validates :uname, presence: true, uniqueness: { case_sensitive: false } , length: { maximum: 8 }
    #pname: text
    #project: text
    #big: text
    #littles: text
    #cur_pos: text
    #past_pos: text
    #residence: text
    #p_class: integer
    VALID_YEAR = /[\d]{4}/
    validates :p_class, presence: true, format: {with: VALID_YEAR}
end
