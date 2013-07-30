class BrothersMit < ActiveRecord::Base
    self.table_name = 'brothers_mit'
    validates :uname, presence: true
end
