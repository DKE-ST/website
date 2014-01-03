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
  
  def pic_path(root_path)
    return "#{root_path}assets/brothers_img/#{personal.first_name.downcase}_#{personal.last_name.downcase}.jpg"
  end
  
 private
 
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
    begin
      name_parts=big_name.split
      return BrothersPersonal.select('uname','first_name','last_name').find_by(first_name: name_parts[0], last_name: name_parts[1]).uname
    rescue
      return big_name
    end
  end
  
  def set_little(little_names)
    output= Array.new([])
    little_names.split(", ").each do |name| 
      begin
        name_parts=name.split
        output << BrothersPersonal.select('uname','first_name','last_name').find_by(first_name: name_parts[0], last_name: name_parts[1]).uname
      rescue
        output << name
      end
    end
    return output.join(",")
  end

end