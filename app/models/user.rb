class User < ActiveRecord::Base
  has_one :shadow
  has_one :brother
  #id      int(11) 
  #uname   varchar(8)
  #mit_id  varchar(9)
  #group   varchar(9)
  #chicken   varchar(10)
  #created_at  datetime 
  #updated_at  datetime
  
  def update_attributes(params)
    usr_params = user_params(params)
    if usr_params.include?(:password)
      passwd = usr_params.delete(:password)
      if passwd.empty?
        self.shadow.destroy unless self.shadow.nil?
      elsif passwd != "~"
        if self.shadow.nil?
          self.add_passwd(passwd)
        else
          self.shadow.ch_passwd(passwd)
        end
      end
    end
    if self.brother
      self.brother.user_id = nil
      self.brother.save
    end
    if usr_params.include?(:brother)
      brother_id = usr_params.delete(:brother)
      if brother_id != 'null'
        brother = User::Brother.find(brother_id)
        brother.user_id = self.id
        brother.save
      end
    end
    super(usr_params)
  end
  
  #Adds shadow property for a user
  #NOTE: This property is used by apache for storing non-ldap user's passwords
  def add_passwd(password)
    return false unless self.shadow.nil?
    passwd = User::Shadow.get_hash(self.uname, password)
    return self.create_shadow(uname: self.uname, passwd: passwd)
  end
  
  #Returns mit ldap entry if one exists for a user
  def mit_ldap
    #return nil if true
    return @ldap if @ldap
    return nil unless @ldap.nil?
    begin
      @ldap = User::MitLdap.find(uname)
      return @ldap
    rescue
      @ldap = false
      return nil
    end
  end
  
  ################Static Methods ######################
  def self.list(params = {})
    user_list = []
    users = self
    users = users.where(group: params["group"]) unless params["group"].blank?
    users = users.where(chicken: params["admin"]) unless params["admin"].blank?
    users.select("*").order("uname").each do | user |
      entry = {id: user.id,
               uname: user.uname,
               group: user.group,
               admin: user.chicken}
      if user.brother
        entry[:class] = user.brother.mit_info.year
        entry[:first_name] = user.brother.first_name
        entry[:last_name] = user.brother.last_name
        entry[:residence] = !user.brother.dke_info.residence.nil?
      elsif user.mit_ldap
        entry[:class] = user.mit_ldap.year
        entry[:first_name] = user.mit_ldap.first_name
        entry[:last_name] = user.mit_ldap.last_name
      else
        entry[:class] = nil
        entry[:first_name] = ""
        entry[:last_name] = ""
      end
      entry[:class] = (entry[:class].nil?)?"":entry[:class]
      class_check = params["year"].blank? || (entry[:class].to_i == params["year"].to_i)
      house_check = params["house"].blank? || (entry[:residence].blank? ^ (params["house"] == "True"))
      user_list << entry if class_check && house_check
    end
    user_list.sort_by!{ |a| [a[:last_name], a[:first_name]]}
    return user_list
  end
  
 private
  
  def user_params(params)
    return params.require(:user).permit(:uname, :group, :chicken, :password, :brother)
  end
end
