class User::Shadow < ActiveRecord::Base
  has_paper_trail
  belongs_to :user
  #uname   varchar(8)
  #user_id int(11)
  #passwd  text
  
  #Changes user's password
  #ATTENTION: password cannot contain the following symbols "'`
  def ch_passwd(password)
    passwd = User::Shadow.get_hash(self.uname, password)
    self.passwd = passwd
    self.save
    return true
  end
  
  #Verifies if their current password matches the hash in the database
  def verify(passwd)
    /[$]apr1[$](.+)[$].+/ =~ self.passwd
    newhash = `openssl passwd -apr1 -salt #{Regexp.last_match(1)} '#{passwd}'`[0..-2]
    return newhash == self.passwd
  end
  
  #Validate passwords
  def self.check_passwd(password1, password2, shadow = nil)
    if password1.blank?
      return "cannot be blank"
    elsif password1.length < 8
      return "must be at least 8 characters"
    elsif password1 != password2
      return  "do not match"
    elsif password1 =~ /"|'|`|~/
      return "cannot contain the following characters: \" ' `"
    elsif shadow.nil?
      return 0
    elsif shadow.verify(password1)  #Only checked is a password entry already exists
      return "cannot be the same as your current one"
    else
      return 0
    end
  end
  
  #Calls system function to get a user's password hash
  def self.get_hash(uname, password)
    passwd = `htpasswd -nb #{uname} '#{password}'`
    return passwd[uname.length+1..-3]
  end
  
end
