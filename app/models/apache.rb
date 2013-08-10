class Apache
  
  def self.in_group(group_name)
    #ENV['REMOTE_USER'] = "wallace4" unless Rails.env.production?
    return Apache.groups(request.env['REMOTE_USER']).include? group_name
  end
  
  def self.exists(uname)
    return self.read.to_s.split(/\W+/).include? uname
  end
  
  def self.groups(uname)
    groups=Array([])
    File.open(group_path).each_line do |line|
      if (line =~/^\w+:\w+/)
        ofset = line.index(':')
        user_list = line[ofset..-1]
        if user_list.index(uname)
          groups << line[0..ofset-1]
        end
      end
    end
    return groups
  end
  
  def self.password(uname, password)
    system("htpasswd -b /etc/apache2/dke_users.passwd #{uname} #{password}")
  end
  
  def self.rmpswd(uname)
    system("htpasswd -D /etc/apache2/dke_users.passwd #{uname}")
  end
  
  def self.update_positions(params)
    apache_users = read
    apache_users.each do | position , officer |
      unless params[position].nil?
        if officer[0] != params[position]
          apache_users[position] = [params[position]]
          old_officer = BrothersDke.find_by(uname: officer[0])
          old_officer.add_past_pos(position)
          old_officer.rm_current_pos(position)
          new_officer = BrothersDke.find_by(uname: params[position])
          new_officer.add_current_pos(position)
        end
      end
    end
    write(apache_users)
  end
  
  def self.add(uname, group, year = nil, paswd = nil)
    year = year.to_s
    apache_users = read
    return "#{uname} already exists" if apache_users[group].to_s.split(/\W+/).include? uname
    if group == "dkeaffil"
      apache_users["dkeaffil"] << uname
    elsif group =~ /dke(bro|pledge)/ && year
      if apache_users[group][year]
        apache_users[group][year] << uname 
      else
        apache_users[group][year] = [uname]
      end
    else
      if apache_users[group]
        apache_users[group] << uname 
      else
        apache_users[group] = [uname]
      end
    end
    #puts "Result: #{apache_users}"
    password(uname, paswd) if paswd
    return write(apache_users)
  end
  
  def self.rm(uname, group = nil)
    apache_users = read
    if group
      apache_users[group].delete(uname) if apache_users[group].include? uname
    elsif apache_users.to_s.split(/\W+/).include? uname
      apache_users.each do | tmp , subsec |
        if subsec.class == Array
          subsec.delete(uname)
        else
          subsec.each do | year , names |
            names.delete(uname)
          end
        end
      end
    end
    #puts "Result: #{apache_users}"
    rmpswd(uname) if group.nil?
    return write(apache_users)
  end
  
 private
 
  def self.group_path
    return '/etc/apache2/dke_users.groups'# if Rails.env.production?
    #return '/home/justin/phpSite/dke_users.groups'
  end
  
  def self.read
    groups = {"dkebro" => Hash.new, "dkepledge" => Hash.new, "dkeaffil" => Array.new([])}
    desc = ""
    File.open(group_path).each_line do |line|
      if line =~ /#dke(\d{4}|alum)/
        desc = line.match(/(\d{4}|alum)/).to_s
      elsif line =~ /dkebro/
        groups["dkebro"][desc] = line.sub(/(dkebro:|$|\n)/, "").split
      elsif line =~ /dkepledge/
        groups["dkepledge"][desc] = line.sub(/(dkepledge:|$|\n)/, "").split
      elsif line =~ /[a-z]+:(\S+\s?)+/
        groups[line.match(/\w+/).to_s] = line.sub(/(\w+:|\W+)/, "").split
      end
    end
    groups["dkebro"].except!("alum")
    groups["broporn"].delete("broporn")
    return groups
  end
  
  def self.write(apache_users)
    apache_string = "#dkealum\r\ndkebro:dkealum\r\n"
    apache_users.each do | group , subsection |
      if subsection.class == Array
        apache_string += "#{group}:#{subsection.join(' ')}\r\n"
      else
        subsection.each do | year , members |
          apache_string += "#dke#{year}\r\n#{group}:#{members.join(' ')}\r\n"
        end
      end      
    end
    File.open(group_path , "w") do |file|
      file.write(apache_string)
    end
    return nil
  end
end
