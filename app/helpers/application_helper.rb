module ApplicationHelper

  def get_name(username)
    tmp = BrothersPersonal.find_by( uname: username)
    if tmp
      return "#{tmp.first_name} #{tmp.last_name}"
    else
      return username
    end
  end

end
