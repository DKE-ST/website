class User::Shadow < ActiveRecord::Base
  belongs_to :user
  #uname   varchar(8)
  #user_id int(11)
  #passwd  text
  
  #Changes user's password
  #ATTENTION: password cannot contain the following symbols "'`
  def ch_passwd(password)
    return false if password =~ /"|'|`/
    passwd = User::Shadow.get_hash(self.uname, password)
    self.passwd = passwd
    return self.save
  end
  
  #Calls system function to get a user's password hash
  def self.get_hash(uname, password)
    passwd = `htpasswd -nb #{uname} '#{password}'`
    return passwd[uname.length+1..-3]
  end
end
