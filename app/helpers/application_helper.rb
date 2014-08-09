module ApplicationHelper
  
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
