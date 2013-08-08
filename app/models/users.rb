class Users
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :uname , :first_name, :last_name, :mit_class, :p_class, :student, :group, :password, :pswd2
  validates :password, presence: true, format: {with: /\A\S+\z/}, length: { minimum: 8 }
  def initialize(attributes = {})
    if attributes.class == ActionController::Parameters || attributes.class == Hash
      attributes.each do |name, value|
        send("#{name}=", value)
      end
      @personal = BrothersPersonal.new
      @mit = BrothersMit.new
      @dke = BrothersDke.new
    else
      self.uname = attributes
      self.group = Apache.groups(uname)[0]
    end
  end
  
  def create
    year = nil
    pswd = nil
    return "#{uname} already exists" if Apache.read.to_s.include? uname
    if !student?
      return "#{uname} is not a valid kerberos" if student=="1"
      return "" unless valid?
      return "Passwords do not match" unless password == pswd2
      pswd = password
    end
    if group != "dkeaffil"
      if student?
        set_personal(uname, ldap.givenName, ldap.sn)
        set_mit(uname, ldap.year)
      elsif student=="0"
        set_personal(uname, first_name, last_name)
        set_mit(uname, mit_class)
      else
        return "#{uname} is not a valid kerberos"
      end
      set_dke(uname, p_class)
      return "" unless personal.valid? && mit.valid? && dke.valid?
      personal.save
      mit.save
      dke.save
    end
    return Apache.add(uname, group, mit_class, pswd)
  end
  
  def update(params)
    if personal.update_attributes(brother_personal_params(params)) && 
       mit.update_attributes(brother_mit_params(params)) && 
       dke.update_attributes(brother_dke_params(params))
      if params[:new_pwd]=="1"
        password=params[:password]
        Apache.password(personal.uname, password) if valid?
        return valid?
      end
      return true
    else
      return false
    end          
  end
  
  def destroy
    personal.destroy if personal
    mit.destroy if mit
    dke.destroy if dke
    Apache.rm(uname)
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
  
  def ldap
    return @ldap if @ldap
    return nil unless @ldap.nil?
    begin
      @ldap = MitStudents.find(uname)
      return @ldap
    rescue
      @ldap = false
      return nil
    end
  end
  
  def admin?
    return "brochicken" if Apache.groups(uname).include? "brochicken"
    return "broporn" if Apache.groups(uname).include? "broporn"
    return nil
  end
  
  def student?
    return false unless ldap
    return ldap.eduPersonAffiliation=="student"
  end
  
  ######helper functions############
  
 private
  
  def set_personal(uname,first,last)
    personal.uname = uname
    personal.first_name = first
    personal.last_name = last
    personal.phone = ""
    personal.bio = ""
    personal.activities = ""
    personal.hobbies = ""
    personal.pro_team = ""
    personal.college_team = ""
    personal.movie = ""
    personal.quote = ""
    personal.hometown = ""
  end
  
  def set_mit(uname, year)
    mit.uname = uname
    mit.majors = ""
    mit.minors = ""
    mit.concentration = ""
    mit.extracurriculars = ""
    mit.interests = ""
    mit.urops = ""
    mit.internships = ""
    mit.fav_classes = ""
    mit.year = year
  end
  
  def set_dke(uname, p_class)
    dke.uname = uname
    dke.pname = ""
    dke.project = ""
    dke.big = ""
    dke.littles = ""
    dke.cur_pos = ""
    dke.past_pos = ""
    dke.residence = ""
    dke.p_class = p_class
  end
  
 private
 
  def brother_personal_params(params)
    params[:brothers_personal][:uname] = params[:users][:uname]
    params.require(:brothers_personal).permit(:uname)
  end
  
  def brother_mit_params(params)
    params[:brothers_mit][:uname] = params[:users][:uname]
    params.require(:brothers_mit).permit(:uname, :year)
  end
  
  def brother_dke_params(params)
    params[:brothers_dke][:uname] = params[:users][:uname]
    params.require(:brothers_dke).permit(:uname, :p_class, :cur_pos, :past_pos)
  end
  
end
