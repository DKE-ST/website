class BrothersController < ApplicationController
  
  def profile
    ENV['REMOTE_USER'] = 'wallace4' if !Rails.env.production?
    @brother = BrothersPersonal.find_by(uname: ENV['REMOTE_USER'])
    @brother_mit = BrothersMit.find_by(uname: ENV['REMOTE_USER'])
    @brother_dke = BrothersDke.find_by(uname: ENV['REMOTE_USER'])
    if params.include? "brothers_personal"
      upload(@brother.full_name) if params.require(:brothers_personal).include? "picture"
      if @brother.update_attributes(brother_personal_params)
        flash[:success] = "Information updated"
      end
      render 'profile'
    end
    if params.include? "brothers_mit"
      if @brother_mit.update_attributes(brother_mit_params)
        flash[:success] = "Information updated"
      end
      render 'profile'
    end
    if params.include? "brothers_dke"
      if @brother_dke.update_attributes(brother_dke_params)
        flash[:success] = "Information updated"
      end
      render 'profile'
    end
  end
  
  def index
    @brothers= Hash.new
    class_map = BrothersMit.select("uname, year").order("year DESC")
    name_map = BrothersPersonal.select("first_name, last_name")
    class_map.each do |user|
      @brothers[user.year] = Array.new([]) if !@brothers.include? user.year
      @brothers[user.year] << [name_map.find_by(uname: user.uname).full_name, user.uname]
    end
    @brothers.each do |key, value|
      value.sort!
    end
  end
  
  def show
    @brother = BrothersPersonal.find_by(uname: params[:id])
    @brother_mit = BrothersMit.find_by(uname: params[:id])
    @brother_dke = BrothersDke.find_by(uname: params[:id])
  end
  
  def edit
    @brother = BrothersPersonal.find_by(uname: params[:id])
    @brother_mit = BrothersMit.find_by(uname: params[:id])
    @brother_dke = BrothersDke.find_by(uname: params[:id])
  end
  
  def update
    @brother = BrothersPersonal.find_by(uname: params[:id])
    @brother_mit = BrothersMit.find_by(uname: params[:id])
    @brother_dke = BrothersDke.find_by(uname: params[:id])
    if @brother.update_attributes(brother_personal_params) &&
      @brother_mit.update_attributes(brother_mit_params) &&
      @brother_dke.update_attributes(brother_dke_params)
      flash[:success] = "Information updated"
      redirect_to "#{brothers_url}/#{@brother.uname}"
    else
      render 'edit'
    end
  end
  
  private
  
  def upload(full_name)
    uploaded_io=params[:brothers_personal][:picture]
    File.open(Rails.root.join("public", "assets", "brothers_img", "#{full_name}.jpg"), "w") do |file|
      file.write(upladed_io.read)
    end
  end
  
    def brother_personal_params
      params.require(:brothers_personal).permit(:hometown, :phone, :quote, :bio)
    end
    
    def brother_mit_params
      params.require(:brothers_mit).permit(:majors, :minors, :concentration, :extracurriculars, :interests, :urops, :internships, :fav_classes)
    end
    
    def brother_dke_params
      params[:brothers_dke][:big] = set_big(params[:brothers_dke][:big])
      params[:brothers_dke][:littles] = set_little(params[:brothers_dke][:littles])
      params.require(:brothers_dke).permit(:pname, :project, :big, :littles, :cur_pos, :past_pos, :residence)
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
