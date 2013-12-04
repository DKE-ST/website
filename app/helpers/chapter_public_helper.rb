module ChapterPublicHelper
  
  def get_occupants(rooms)
    result = Array.new([])
    for i in 0..rooms.capacity-1
      unless rooms["occupant#{i}"] == ''
        res = rooms["occupant#{i}"]
        brother = BrothersPersonal.select('uname','first_name','last_name').find_by(uname: res)
        if (brother)
          result << link_to(brother.full_name , "#{brothers_path}/#{res}")
        else
          result << res
        end
      end
    end
    return result.join(', ').html_safe
  end
  
end