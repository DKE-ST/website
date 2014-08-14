class User::Brother < ActiveRecord::Base
  belongs_to :user
  has_one :mit_info, dependent: :destroy 
  accepts_nested_attributes_for :mit_info, allow_destroy: true
  has_one :dke_info 
  #id  int(11)
  #user_id   int(11)
  #first_name  text
  #last_name   text
  #phone   varchar(10)
  #email   text
  #bio   text
  #activities  text
  #hobbies   text
  #pro_team  text
  #college_team  text
  #movie   text
  #quote   text
  #hometown  text
  #created_at  datetime
  #updated_at  datetime
  
  #Method to return brother index information by year
  def self.get_indexes
    brothers = Hash.new
    class_map = User::Brother::MitInfo.select("year, brother_id").order("year DESC")
    class_map.each do | bro |
      brothers[bro.year] = Array.new([]) if !brothers.include? bro.year
      brothers[bro.year] << [bro.brother.full_name, bro.brother_id]
    end
    brothers.each do |key, value|
      value.sort!
    end
    return brothers
  end
  
  #Static method to return name to dke_info map for use in brother creation/editing
  def self.name_dke_info_id_map
    brothers = Hash.new
    class_map = User::Brother::MitInfo.select("year, brother_id").order("year DESC")
    class_map.each do | bro |
      brothers[bro.year] = Array.new([]) if !brothers.include? bro.year
      brothers[bro.year] << [bro.brother.full_name, bro.brother.dke_info.id]
    end
    brothers.each do |key, value|
      value.sort!
    end
    return brothers
  end
  
  #Override method for update attributes, so mit_info and dke_info are updated as well
  def update_attributes(params)
    return super(brother_params(params)) &&
           self.mit_info.update_attributes(mit_info_params(params)) &&
           self.dke_info.update_attributes(dke_info_params(params))
  end
  
  #Returns full name from brother information
  def full_name
    return "#{self.first_name} #{self.last_name}"
  end
  
  #Returns absolute path for brother image
  def pic_path(root_path)
    return "#{root_path}assets/brothers_img/#{self.first_name.downcase}_#{self.last_name.downcase}.jpg"
  end
  
 private
  #Only allows valid brother parameters through
  def brother_params(params)
    return params.require(:user_brother).permit(:first_name, :last_name, :hometown, :email, :phone, :quote, :bio)
  end
  
  #Only allows valid mit_info parameters through
  def mit_info_params(params)
    return params.require(:user_brother).require(:mit_info).permit(:year, :majors, :minors, :concentration, :extracurriculars,
                                                                   :interests, :urops, :internships, :fav_classes)
  end
  
  #Only allows valid dke_info parameters through
  def dke_info_params(params)
    if params[:user_brother][:dke_info][:little_id]
      params[:user_brother][:dke_info][:little_id] = params[:user_brother][:dke_info][:little_id].values.join(",")
    end
    params.require(:user_brother).require(:dke_info).permit(:p_class, :p_name, :project, :past_pos, :big_id, :little_id)
  end
end
