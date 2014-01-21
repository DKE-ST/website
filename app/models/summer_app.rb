class SummerApp < ActiveRecord::Base
  #ID: integer
  #first_name: text
  validates :first_name, presence: true
  #last_name: text
  validates :last_name, presence: true
  #email: text
  validates :email, presence: true, format: {:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/}
  #phone: integer
  VALID_PHONE_NUM = /(^$|[\d]{10})/
  validates :phone, presence: true, format: {with: VALID_PHONE_NUM}, length: { is: 10 }
  #school: text
  validates :school, presence: true
  #year: integer
  #dke_brother: text
  #q1: text
  validates :q1, presence: true
  #q2: text
  validates :q2, presence: true
  #q3: text
  validates :q3, presence: true
  #q4: text
  validates :q4, presence: true
  #q5: text
  validates :q5, presence: true
  #q6: text
  validates :q6, presence: true
  #q7: text
  validates :q7, presence: true
  #q8: text
  validates :q8, presence: true
  #q9: text
  validates :q9, presence: true
  #q10: text
  #room_pref: integer
  #finding: string
  #lived_before: boolean
  #car: boolean
end
