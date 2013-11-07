class ChapterPublicController < ApplicationController
  
  def contact
    @officers = Hash.new
    position_map =  BrothersDke.select("cur_pos, uname")
    position_map.each do |position|
      unless position.cur_pos == ""
        name = BrothersPersonal.find_by(uname: position.uname).full_name
        year = BrothersMit.find_by(uname: position.uname).year.to_s[2..3]
        @officers[position.cur_pos] = {uname: position.uname, full_name: name, year: year}
      end
    end
  end
  
end
