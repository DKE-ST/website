class BrothersDke < ActiveRecord::Base
    self.table_name = 'brothers_dke'
    validates :uname, presence: true
end
