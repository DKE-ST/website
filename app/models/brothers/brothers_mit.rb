class BrothersMit < ActiveRecord::Base
    self.table_name = 'brothers_mit'
    #id: integer
    #uname: string
    validates :uname, presence: true, uniqueness: { case_sensitive: false } , length: { maximum: 8 }
    #majors: string
    #minors: string
    #concentration: string
    #extracurriculars: text
    #interests: text
    #urops: text
    #internships: text
    #fav_classes: text
    #year: integer
    VALID_YEAR = /[\d]{4}/
    validates :year, presence: true, format: {with: VALID_YEAR}
end
