module ApplicationHelper
  
  #Humanize dates
  def humanize(date)
    return date.strftime("%B %e, %Y")
  end
  
  #Renders errors in form validation 
  def render_errors(form)
    return nil if form.nil?
    provide(@target = form)
    return (render "shared/error_messages").html_safe
  end
  
  #Returns the full name for a brother, otherwise, just the user's username
  def get_name()
    return @me.uname if @me.brother.nil?
    return @me.brother.full_name
  end
  
  #Returns page title based on user's login status and parameter page_title
  def gen_title(page_title)
    puts @me.valid_user?
    if !@me.valid_user?
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
  
  def gen_point_url(name)
    off = Chapter::Officer.find_by(name: name)
    return main_app.officer_house_points_path(off)
  end
  
  def gen_officer_submenus
    out = "".html_safe
    @me.positions.each do | pos |
      if File.exists?("app/views/layouts/navbar/officer/_#{pos.name}.html.erb")
        out += "<li id='gen_sub' class='dropdown-submenu'><a>".html_safe + pos.title + "</a>".html_safe
        out += "<ul class='dropdown-menu'>".html_safe
        out += render("layouts/navbar/officer/#{pos.name}").html_safe
        out += "</ul></li>".html_safe
      end
    end
    return out
  end
  
  def gen_officer_links
    out = "".html_safe
    @me.positions.each do | pos |
      if File.exists?("app/views/layouts/navbar/officer/_#{pos.name}.html.erb")
        out += "<div class='accordion-group'><div class='accordion-heading'>".html_safe
        out += "<a class='accordion-toggle' data-toggle='collapse' data-parent='#linkAccordian' href='#collapse".html_safe + pos.name
        out += "'>".html_safe + pos.title + "</a></div>".html_safe
        out += "<div id='collapse".html_safe + pos.name + "' class='accordion-body collapse'>".html_safe
        out += "<div class='accordion-inner'><ul>".html_safe
        out += render("layouts/navbar/officer/#{pos.name}").html_safe
        out += "</ul></div></div></div>".html_safe
      end
    end
    return out
  end
  
end
