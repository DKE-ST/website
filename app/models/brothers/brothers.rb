class Brothers
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :uname
  
  def initialize(uname)
    self.uname = uname
  end
  
  def update_attributes(params)
    upload(params) if params.require(:brothers_personal).include? "picture"
    return personal.update_attributes(brother_personal_params(params)) &&
             mit.update_attributes(brother_mit_params(params)) &&
             dke.update_attributes(brother_dke_params(params))
  end
  
  def personal
    @personal = BrothersPersonal.find_by(uname: self.uname) unless @personal
    return @personal
  end
  
  def mit
    @mit = BrothersMit.find_by(uname: self.uname) unless @mit
    return @mit
  end
  
  def dke
    @dke = BrothersDke.find_by(uname: self.uname) unless @dke
    return @dke
  end
  
  def points
    @points = HousePoints.get_point_breakdown(self.uname) unless @points
    return @points
  end
  
  def points_total
    return HousePoints.total_points(self.uname)
  end
  
  def pic_path(root_path)
    return "#{root_path}assets/brothers_img/#{personal.first_name.downcase}_#{personal.last_name.downcase}.jpg"
  end
  
 #private
 
  def upload(params)
    uploaded_io=params[:brothers_personal][:picture]
    File.open(pic_path(Rails.root.join("public/").to_s), "wb") do |file|
      file.write(uploaded_io.read)
    end
  end
  
  def brother_personal_params(params)
    params.require(:brothers_personal).permit(:hometown, :phone, :quote, :bio)
  end
  
  def brother_mit_params(params)
    params.require(:brothers_mit).permit(:majors, :minors, :concentration, :extracurriculars, :interests, :urops, :internships, :fav_classes)
  end
  
  def brother_dke_params(params)
    params[:brothers_dke][:big] = set_big(params[:brothers_dke][:big]) if params[:brothers_dke][:big]
    params[:brothers_dke][:littles] = set_little(params[:brothers_dke][:littles]) if params[:brothers_dke][:littles]
    params.require(:brothers_dke).permit(:pname, :project, :big, :littles, :past_pos, :residence)
  end
  
  def set_big(big_name)
    name_parts=big_name.split
    if BrothersPersonal.exists?(first_name: name_parts[0], last_name: name_parts[1])
      big_uname = BrothersPersonal.find_by(first_name: name_parts[0], last_name: name_parts[1]).uname
    elsif BrothersDke.exists?(uname: big_name)
      big_uname = big_name
    end
    if big_uname
      big = BrothersDke.find_by(uname: big_uname)
      littles = big.littles.split(",")
      if littles.index(self.personal.full_name)
        ind = littles.index(self.personal.full_name)
        littles[ind] = self.uname
        big.littles = littles.join(",")
        big.save
      elsif littles.index(self.uname).nil?
        littles << self.uname
        big.littles = littles.join(",")
        big.save
      end
      return big_uname
    else
      return big_name
    end
  end
  
  def set_little(little_names)
    output= Array.new([])
    little_names.split(", ").each do |name| 
      name_parts=name.split
      if BrothersPersonal.exists?(first_name: name_parts[0], last_name: name_parts[1])
        little_uname = BrothersPersonal.find_by(first_name: name_parts[0], last_name: name_parts[1]).uname
      elsif BrothersDke.exists?(uname: name)
        little_uname = name
      end
      if little_uname
        little = BrothersDke.find_by(uname: little_uname)
        if little.big.nil? || little.big.empty? || little.big == self.personal.full_name
          little.big = self.uname
          little.save
        end
        output << little_uname
      else
        output << name
      end
    end
    return output.join(",")
  end

end