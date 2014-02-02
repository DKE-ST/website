class PositionsController < AuthController
  
  def index
    @officers = Hash.new
    position_map =  Positions.select("position, name, uname, contact, disp")
    position_map.each do |pos|
      unless pos.uname.empty?
        name = BrothersPersonal.find_by(uname: pos.uname).full_name
        year = BrothersMit.find_by(uname: pos.uname).year.to_s[2..3]
      end
      @officers[pos.position] = {uname: pos.uname, full_name: name, year: year, contact: pos.contact, name: pos.name, disp: pos.disp}
    end
  end
  
  def new
    @brothers = Brothers.brother_list
    @officer = Positions.new
  end
  
  def edit
    @brothers = Brothers.brother_list
    @officer = Positions.find_by(position: params[:id])
  end
  
  def create
    position = exec_params
    @officer = Positions.new(position)
    if (position[:disp]=="1" && position[:contact].empty?) || !@officer.valid?
      @brothers = brother_list
      if @officer.valid?
        flash[:fail] = "Contact For: field is required to display on contact page"
      end
      render "new"
    else
      @officer.save
      flash[:success] = "Officer has been created"
      redirect_to positions_url
    end
  end
  
  def update
    position = exec_params
    @officer = Positions.find_by(position: params[:id])
    @brothers = Brothers.brother_list
    if position[:disp]=="1" && position[:contact].empty?
      flash[:fail] = "Contact For: field is required to display on contact page"
      render "edit"
    elsif @officer.update(position)
      flash[:success] = "Officer has been updated"
      redirect_to positions_url
    else
      render "edit"
    end
  end
  
  def destroy
    @officer = Positions.find_by(position: params[:id])
    @officer.destroy
    flash[:success] = "#{@officer.name} destroyed."
    redirect_to positions_url
  end
  
  def mass_edit
    @officers = Positions.select("position, name, uname")
    @brothers = Brothers.brother_list
  end
  
  def mass_update
    params.require("officers").each do |position, officer|
      Positions.update_position(position, officer)
    end
    flash[:success] = "Officers updated"
    redirect_to positions_url
  end
  
 private
 
 def exec_params
   return params.require(:positions).permit(:position, :name, :uname, :disp, :contact, :exec)
 end
  
end
