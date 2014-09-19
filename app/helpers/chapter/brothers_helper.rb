module Chapter::BrothersHelper
  
  ############ edit.html.erb ###################
  
  def brother_info_delete
    return link_to("Delete" , 
            brother_path , 
            method: :delete, 
            data: { confirm: "Are you sure you would like to delete #{@brother.full_name}?" },
            :class => "btn")
  end
  
  ############ edit.html.erb & new.html.erb ###################
  
  #Generates select boxes for big brother information
  #@param f_dke: form object for user::brother::dke_info
  #@param dke_info: dke_info instance for selected user
  def big_select(f_dke, dke_info)
    big = (dke_info.nil?)?nil:dke_info.big
    brother_list = User::Brother.name_dke_info_id_map
    brother_list[""] << ["New Brother", "new"]
    big_options = grouped_options_for_select(brother_list, selected=dke_info.big_id)
    return f_dke.select(:big_id, big_options, {}, class:"chosen-select")
  end
  
  #Return length of littles array if dke_info is not nil, otherwise 0
  #@param dke_info: dke_info instance for selected user
  def little_num(dke_info)
    return 1 if dke_info.nil?
    return [dke_info.littles.length, 1].max
  end
  
  #Generates div for all little brothers for a given user
  #@param dke_info: dke_info instance for selected user
  def little_select_div(dke_info)
    little_ids = (dke_info.nil?)?[]:dke_info.little_ids
    if little_ids.length == 0
      return little_select(nil,"0")
    else
      out = "".html_safe
      for i in 0..(little_ids.length-1)
        out += little_select(little_ids[i], i.to_s)
      end
      return out
    end
  end
  
  #Generates select boxes for little brother information
  #@param little: dke_info instance for little brother
  #@param tag: string (should only have values: __n, or integer >= 0
  def little_select(little_id, tag)
    brother_list = User::Brother.name_dke_info_id_map
    brother_list[""] << ["New Brother", "new"]
    out = '<div class="bl-label">Little Brother: '.html_safe
    name = "user_brother[dke_info][little_ids][#{tag}]"
    if little_id.nil?
      little_options = grouped_options_for_select(brother_list)
      if tag == "__n"
        out += select_tag(name , little_options, id: "select_little#{tag}")
      else
        out += select_tag(name, little_options, class:"chosen-select", id: "select_little#{tag}")
      end
    else
      little_options = grouped_options_for_select(brother_list, selected: little_id)
      out += select_tag(name, little_options, class:"chosen-select", id: "select_little#{tag}")
    end
    out += "</div>".html_safe
    return out
  end
  
  ############ show.html.erb ###################
  #Returns link to big brother information
  def big_link(big)
    return link_to(big.brother.full_name , "#{brothers_path}/#{big.brother_id}")
  end
  
  #Returns links to little brother information
  def little_links(littles)
    result = []
    littles.each do | little |
        result << link_to(little.brother.full_name , "#{brothers_path}/#{little.brother_id}")
    end
    return result.join(', ').html_safe
  end
  
  #Returns link to residence information
  def room_link(room)
      return link_to(room.name, "#TODO")
  end
  
  #Returns positions user holds
  def get_positions(positions)
    result = []
    positions.each do | pos |
      result << pos.title
    end
    return result.join(', ').html_safe
  end
  ########################################################################
    
end
