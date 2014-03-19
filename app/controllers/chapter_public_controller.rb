class ChapterPublicController < ApplicationController
  
  def home
  end
  
  def about
  end
  
  def president_letter
    @content = ChapterPublic.find_by(pname: "letter")
  end
  
  def contact
    @officers = Hash.new
    position_map =  Positions.select("position, name, uname, contact, disp")
    position_map.each do |pos|
      if pos.disp && !pos.uname.empty?
        name = BrothersPersonal.find_by(uname: pos.uname).full_name
        year = BrothersMit.find_by(uname: pos.uname).year.to_s[2..3]
        @officers[pos.position] = {uname: pos.uname, full_name: name, year: year, contact: pos.contact, name: pos.name}
      end
    end
  end

end
