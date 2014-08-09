module ApplicationHelper
  
  #Not used yet.  
  def render_errors(user)
    return nil if user.nil?
    provide(@target = user)
    return (render "shared/error_messages").html_safe
  end
  
  #Returns the full name for a brother, otherwise, just the user's username
  def get_name()
    return @me.uname if @me.brother.nil?
    return @me.brother.full_name
  end
  
  #Returns page title based on user's login status and parameter page_title
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
