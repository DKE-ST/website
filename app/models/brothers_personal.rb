class BrothersPersonal < ActiveRecord::Base
    self.table_name = 'brothers_personal'
    validates :uname, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
end
