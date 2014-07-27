class User < ActiveRecord::Base
  has_one :shadow
  has_one :brother
  #id      int(11) 
  #uname   varchar(8)
  #group   varchar(9)
  #chicken   varchar(10)
  #created_at  datetime 
  #updated_at  datetime  
  
  def add_passwd(password)
    return false unless self.shadow.nil?
    passwd = User::Shadow.get_hash(self.uname, password)
    return self.create_shadow(uname: self.uname, passwd: passwd)
  end
  
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
end
