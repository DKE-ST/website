module Chapter::BrothersHelper
  
  ############ edit.html.erb ###################
  
  #Generates select boxes for big brother information
  #@param f_dke: form object for user::brother::dke_info
  #@param dke_info: dke_info instance for selected user
  def big_select(f_dke, dke_info)
    big = (dke_info.nil?)?nil:dke_info.big
    brother_list = User::Brother.name_dke_info_id_map
    if big.nil?
      out = select_tag("year_big", options_for_select(brother_list), class: "year_select")
      out += '<div class="btn sel_yr" id="big">Select</div>
              <div class="btn clear hidden" id="big">Clear</div><br>'.html_safe
      out += f_dke.select(:big_id, [], {}, {class: "hidden", id: "select_big"})
    else
      year_options = options_for_select(brother_list, brother_list[big.brother.mit_info.year].to_s)
      big_options = options_for_select(brother_list[big.brother.mit_info.year], selected: big.id)
      out = select_tag("year_big", year_options, class: "year_select")
      out += '<div class="btn sel_yr" id="big">Select</div>
              <div class="btn clear" id="big">Clear</div><br>'.html_safe
      out += f_dke.select(:big_id, big_options, {}, {id: "select_big"})
    end
    return out
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
    littles = (dke_info.nil?)?[]:dke_info.littles
    if littles.length == 0
      return little_select(nil,"0")
    else
      out = "".html_safe
      for i in 0..(littles.length-1)
        out += little_select(littles[i], i.to_s)
      end
      return out
    end
  end
  
  #Generates select boxes for little brother information
  #@param little: dke_info instance for little brother
  #@param tag: string (should only have values: __n, or positive integer
  def little_select(little, tag)
    brother_list = User::Brother.name_dke_info_id_map
    label = '<div class="bl-label">Little Brother:</div>'.html_safe
    sel_div = '<div class="little-field">'.html_safe
    if little.nil?
      out = label + sel_div
      out += select_tag("year_little#{tag}", options_for_select(brother_list), class: "year_select")
      out += "<div class='btn sel_yr' id='little#{tag}'>Select</div>
              <div class='btn clear hidden' id='little#{tag}'>Clear</div><br>".html_safe
      out += select_tag("user_brother[dke_info][little_id][#{tag}]", [], class: "hidden", id: "select_little#{tag}") + "</div>".html_safe
    else
      year_options = options_for_select(brother_list, brother_list[little.brother.mit_info.year].to_s)
      little_options = options_for_select(brother_list[little.brother.mit_info.year], selected: little.id)
      out = label + sel_div
      out += select_tag("year_little#{tag}", year_options, class: "year_select")
      out += "<div class='btn sel_yr' id='little#{tag}'>Select</div>
              <div class='btn clear' id='little#{tag}'>Clear</div><br>".html_safe
      out += select_tag("user_brother[dke_info][little_id][#{tag}]", little_options, id: "select_little#{tag}") + "</div>".html_safe
    end
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
