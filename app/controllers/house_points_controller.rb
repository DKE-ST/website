class HousePointsController < ApplicationController
  
  def show
    @brothers = []
    @officer = Positions.find_by(position: params[:id])
    points = HousePoints.select("uname, #{params[:id]}_f, #{params[:id]}_s")
    points.each do | brother |
      name = BrothersPersonal.find_by(uname: brother.uname).full_name
      p_class = BrothersDke.find_by(uname: brother.uname).p_class
      @brothers << {uname: brother.uname, name: name, p_class: p_class, fall: brother["#{params[:id]}_f"], spring: brother["#{params[:id]}_s"]}
    end
    @brothers.sort_by! {|a| [a[:p_class], a[:name]]}
  end
  
end
