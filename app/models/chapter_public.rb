class ChapterPublic < ActiveRecord::Base
  self.table_name = "chapter_public"
  validates :pname, presence: true, uniqueness: { case_sensitive: false } , length: { maximum: 10 }
  validates :title, presence: true
  validates :content, presence: true
  validates :user, presence: true
  
  def self.gen_chapter_roles
    chapters = ["I am not a brother"]
    wikipg = Nokogiri::HTML(open('http://en.wikipedia.org/wiki/List_of_Delta_Kappa_Epsilon_chapters'))
    roles = wikipg.css('table').css('tr')
    roles.each do | chapter |
      info = chapter.text.split("\n")
      if info[3] == "Yes"
        chapters << "#{info[1]} - #{info[0]}"
      end
    end
    return chapters
  end
end
