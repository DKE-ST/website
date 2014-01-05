module BrothersHelper
  
  def get_room(brother)
      for i in 0..3
        room = HouseRooms.find_by "occupant#{i} = ?", brother.uname
        break if room
      end
      if room
        return link_to(room.name, "#{root_url}house-#{room.id}")
      else
        return brother.residence
      end
  end
  
  def print_type(type, val)
    if type =~ /\S+_[sf]/
      tmp = type.gsub("_s", " Spring").gsub("_f", " Fall")
      return "#{tmp}: #{val}<br>".html_safe
    end
  end
  
  def get_big(big_name)
    big = BrothersPersonal.select('uname','first_name','last_name').find_by(uname: big_name)
    return link_to(big.full_name , "#{brothers_path}/#{big_name}") if big
    return big_name
  end
  
  def get_littles(littles)
    result = Array.new([])
    little_array = littles.split(',')
    little_array.each do |little_uname|
      little = BrothersPersonal.select('uname','first_name','last_name').find_by(uname: little_uname)
      if (little)
        result << link_to(little.full_name , "#{brothers_path}/#{little_uname}")
      else
        result << little_uname
      end
    end
    return result.join(', ').html_safe
  end
  
  def uname_to_name(unames)
    output = Array.new([])
    unames.split(',').each do |uname|
      begin
        output << BrothersPersonal.select('uname','first_name','last_name').find_by(uname: uname).full_name
      rescue
        output << uname
      end
    end
    return output.join(", ")
  end
  
end
