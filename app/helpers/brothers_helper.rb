module BrothersHelper
  
  def render_errors(user)
    provide(@user = user)
    return (render "shared/error_messages").html_safe
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
  
end
