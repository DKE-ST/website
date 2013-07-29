module ApplicationHelper

  def get_name(username)
    if Rails.env.production?
      tmp = BrothersPersonal.find_by( uname: username)
      if tmp
        return "#{tmp.first_name} #{tmp.last_name}"
      else
        return username
      end
     else
       return 'Justin Wallace'
     end
  end
  
  def in_group(group_name)
    if Rails.env.production?
      groups=Array();
      if !File.exists?('/etc/apache2/dke_users.groups')
        return true;
      end
      File.open('/etc/apache2/dke_users.groups').each_line do |line|
        if (line[0]!="#" && line[0]!="\n")
          ofset = line.index(':')
          if line.index(ENV['REMOTE_USER']).begin(ofset)
            gtoups << line[0..ofset]
          end
        end
      end
      if groups.include? group_name
        return true
      else
        return false
      end
     else
       return true
     end
  end
  
  

end
