module Chapter::BrothersHelper
  
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
  
  def get_big(big)
    return link_to(big.brother.full_name , "#{brothers_path}/#{big.brother_id}")
  end
  
  def get_littles(littles)
    result = []
    littles.each do | little |
        result << link_to(little.brother.full_name , "#{brothers_path}/#{little.brother_id}")
    end
    return result.join(', ').html_safe
  end
  
end
