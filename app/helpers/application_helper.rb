module ApplicationHelper
  
  def render_errors(user)
    return nil if user.nil?
    provide(@target = user)
    return (render "shared/error_messages").html_safe
  end

  def get_name(user)
    return user.uname if user.brother.nil?
    return user.brother.full_name
  end
  
  def gen_title(page_title)
    if @me.nil?
      site_title="Delta Kappa Epsilon - Sigma Tau"
    else
      site_title="DKE Server"
    end
    if (page_title!="")
      return "#{site_title} | #{page_title}" 
    else
      return site_title
    end
  end
  
  
  
end
