class User::Shadow < ActiveRecord::Base
  belongs_to :user
  #uname   varchar(8)
  #user_id int(11)
  #passwd  text
  
  #Changes user's password
  #ATTENTION: password cannot contain the following symbols "'`
  def ch_passwd(password1, password2)
    if password1.blank?
      return "cannot be blank"
    elsif password1.length < 8
      return "must be at least 8 characters"
    elsif password1 != password2
      return  "do not match"
    elsif password1 =~ /"|'|`|~/
      return "cannot contain the following characters: \" ' `"
    elsif self.verify(password1)
      return "cannot be the same as your current one"
    end
    passwd = User::Shadow.get_hash(self.uname, password1)
    self.passwd = passwd
    self.save
    return 0
  end
  
  #Verifies if their current password matches the hash in the database
  def verify(passwd)
    /[$]apr1[$](.+)[$].+/ =~ self.passwd
    newhash = `openssl passwd -apr1 -salt #{Regexp.last_match(1)} '#{passwd}'`[0..-2]
    return newhash == self.passwd
  end
  
  #Calls system function to get a user's password hash
  def self.get_hash(uname, password)
    passwd = `htpasswd -nb #{uname} '#{password}'`
    return passwd[uname.length+1..-3]
  end
  
end
