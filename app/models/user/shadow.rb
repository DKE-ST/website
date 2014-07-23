class User::Shadow < ActiveRecord::Base
  belongs_to :user
  #uname   varchar(8)
  #id auth_users reference
  #passwd  text
  
  def ch_passwd(password)
    passwd = User::Shadow.get_hash(self.uname, password)
    self.passwd = passwd
    return self.save
  end
  
  def rm_passwd
    return self.destroy
  end
  
  def self.get_hash(uname, password)
    passwd = `htpasswd -nb #{uname} #{password}`
    return passwd[uname.length+1..-3]
  end
end
