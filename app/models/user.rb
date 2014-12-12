class User < ActiveRecord::Base
  has_one :shadow
  has_one :brother
  #id      int(11) 
  #uname   varchar(8)
  validates :uname, presence: true, uniqueness: true, length: {maximum: 8}
  #mit_id  varchar(9)
  #validates :mit_id, uniqueness: true, length: {maximum: 9}, format: {with: /\A\d*\z/}
  #group   varchar(9)
  #chicken   varchar(10)
  #created_at  datetime 
  #updated_at  datetime
  
  ##Fields used for saving fields stored in other database tables
  attr_accessor :password, :brother_id
  
  #Override to store shadow and brother information as well
  def initialize(params = nil)
    if params.nil?
      super
    else
      super(user_params(params))
    end
  end
  
  #Adds shadow property for a user
  #NOTE: This property is used by apache for storing non-ldap user's passwords
  def add_passwd(password)
    return false unless self.shadow.nil?
    passwd = User::Shadow.get_hash(self.uname, password)
    return self.create_shadow(uname: self.uname, passwd: passwd)
  end
  
  #Override of destroy to delete associated models as well
  def destroy(all = false)
    if all
      self.brother.destroy if self.brother
    end
    self.shadow.destroy if self.shadow
    return super()
  end
  
  #Returns mit ldap entry if one exists for a user
  def mit_ldap
    return nil if Rails.env.test?
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
  
  #Override to update shadow and brother information as well
  def save
    return false unless super
    unless self.password.nil? #checks for password in attributes
      if self.password.empty? #If empty delete
        self.shadow.destroy unless self.shadow.nil?
      elsif self.password != "~" #If ~ it remains unchanged
        if self.shadow.nil?  #if shadow is nil, create instance of model
          self.add_passwd(self.password)
        else
          self.shadow.ch_passwd(self.password)
        end
      end
    end
    #If params includes brother 
    unless self.brother_id == "new"
      begin
        bro_id = self.brother.id
      rescue
        bro_id = nil
      end
      if self.brother_id == 'null' || self.brother_id != bro_id
        #Delete old reference if brother_id is null or not the same as before
        if self.brother
          self.brother.user_id = nil
          self.brother.save
        end
      end
      if self.brother_id != bro_id && self.brother_id != 'null' #Update brother info if brother id has changed
        brother = User::Brother.find(self.brother_id)
        brother.user_id = self.id
        brother.save
      end
    end
    return true
  end
  
  #Override to update shadow and brother information as well
  def update_attributes(params)
    super(user_params(params))
  end
  
  #Override of valid? to check if password requirements are met:
  #--Either a supplied password or a mit kerberos entry
  def valid?(params = {})
    if super(params)
      if self.mit_ldap.nil? && self.password.blank?
        self.errors.add(:password, "can't be blank if kerberos is invalid")
        return false 
      end
      return true
    else
      return false
    end
    
  end
  
  ################Static Methods ######################
  #Returns list of users filtered by params
  #@param params: fields to filter users by
  #@return list of hashes with user information
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
  
  #Creates user and brother model instances for a given uername
  #@param params: hash of usernames - ex. {dummy1: username1, dummy2: username2}
  def self.create_pledges(params)
    params.each do | dummy, username |
      unless User.exists?(uname: username)
        usr_info = User::MitLdap.find(username)
        bro = User::Brother.new
        bro.first_name = usr_info.givenName
        bro.last_name = usr_info.sn
        bro.mit_info.year = usr_info.year
        bro.dke_info.p_class = User::Brother::DkeInfo.cur_p_class
        bro.save
        user = User.new
        user.uname = username
        user.group = "dkepledge"
        user.brother_id = bro.id
        user.save
      end
    end
  end
  
 private
  
  def user_params(params)
    return params.require(:user).permit(:uname, :group, :chicken, :mit_id, :password, :brother_id)
  end
end
