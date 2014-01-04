class PositionsController < AuthController
  
  def index
    @officers = Hash.new
    position_map =  Positions.select("position, name, uname, contact, disp")
    position_map.each do |pos|
      name = BrothersPersonal.find_by(uname: pos.uname).full_name
      year = BrothersMit.find_by(uname: pos.uname).year.to_s[2..3]
      @officers[pos.position] = {uname: pos.uname, full_name: name, year: year, contact: pos.contact, name: pos.name, disp: pos.disp}
    end
  end
  
  def mass_edit
    @officers = Positions.select("position, name, uname")
    @brothers = Array.new([])
    BrothersPersonal.select("uname","first_name, last_name").each do |brother|
      @brothers << [brother.full_name, brother.uname]
    end
    @brothers.sort!
  end
  
  def mass_update
    params.require("officers").each do |position, officer|
      Positions.update_position(position, officer)
    end
    flash[:success] = "Officers updated"
    redirect_to positions_url
  end
    
end
