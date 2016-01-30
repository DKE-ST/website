module Chapter
  def self.table_name_prefix
    'chapter_'
  end
  
  def self.gen_chapter_roles
    chapters = ["I am not a brother"]
    wikipg = Nokogiri::HTML(open('https://en.wikipedia.org/wiki/List_of_Delta_Kappa_Epsilon_chapters'))
    roles = wikipg.css('table').css('tr')
    roles.each do | chapter |
      info = chapter.text.split("\n")
      if info[4] == "Yes"
        chapters << "#{info[2]} - #{info[1]}"
      end
    end
    return chapters
  end
end
