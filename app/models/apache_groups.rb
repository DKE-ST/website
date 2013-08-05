class ApacheGroups
    
  def self.in_group(group_name)
    ENV['REMOTE_USER'] = "wallace4" unless Rails.env.production?
    return self.groups(ENV['REMOTE_USER']).include? group_name
  end
  
  def self.primary_group(uname)
    groups = self.groups(uname)
    return "none" if groups.length==0
    return groups[0]
  end
  
  def self.positions(uname)
    groups = self.groups(uname)
    return [] unless groups.length > 1
    return groups.drop(1)
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
  
  def self.read
    groups = {"dkebro" => Hash.new, "dkepledge" => Hash.new}
    desc = ""
    File.open(group_path).each_line do |line|
      if line =~ /#dke(\d{4}|alum)/
        desc = line.match(/(\d{4}|alum)/).to_s
      elsif line =~ /dkebro/
        groups["dkebro"][desc] = line.sub(/(dkebro:|$|\n)/, "").split
      elsif line =~ /dkepledge/
        groups["dkepledge"][desc] = line.sub(/(dkepledge:|$|\n)/, "").split
      elsif line =~ /[a-z]+:(\S+\s?)+/
        groups[line.match(/\w+/).to_s] = line.sub(/(\w+:|$|\n)/, "").split
      end
    end
    groups["dkebro"].except!("alum")
    groups["broporn"].delete("broporn")
    return groups
  end
  
 private
 
  def self.group_path
    return '/home/justin/webDKE/dke_users.groups' unless Rails.env.production?
    return '/etc/apache2/dke_users.groups'
  end
  
end
