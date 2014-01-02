class PositionsController < ApplicationController
  
  def index
    @officers = Hash.new
    position_map =  Positions.select("position, name, uname, contact, disp")
    position_map.each do |pos|
      name = BrothersPersonal.find_by(uname: pos.uname).full_name
      year = BrothersMit.find_by(uname: pos.uname).year.to_s[2..3]
      @officers[pos.position] = {uname: pos.uname, full_name: name, year: year, contact: pos.contact, name: pos.name, disp: pos.disp}
    end
  end
  
end
