class BrothersPersonal < ActiveRecord::Base
    self.table_name = 'brothers_personal'
    #id: integer
    #uname: string
    validates :uname, presence: true, uniqueness: { case_sensitive: false } , length: { maximum: 8 }
    #last_name: text
    validates :last_name, presence: true
    #first_name: text
    validates :first_name, presence: true
    #phone: string
    VALID_PHONE_NUM = /(^$|[\d]{10})/
    validates :phone, format: {with: VALID_PHONE_NUM}
    #bio: text
    #activities: text (depricated:replaced by BrothersMit.extracurriculars)
    #hobbies: text (depricated:replaced by BrothersMit.interests)
    #pro_team: text (depricated:no longer used)
    #college_team: text (depricated:no longer used)
    #movie: text (depricated:no longer used)
    #quote: text
    #hometown: text
    
    def full_name
      "#{self.first_name } #{self.last_name}"
    end
        
end
