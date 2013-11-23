class ChapterPublic < ActiveRecord::Base
  self.table_name = "chapter_public"
  validates :pname, presence: true, uniqueness: { case_sensitive: false } , length: { maximum: 10 }
    #majors: string
  validates :title, presence: true
  validates :content, presence: true
  validates :user, presence: true
end
