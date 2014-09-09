module UsersHelper
  
  #################Index.html.erb########################
  #Filter select options for index page
  def group_select_filter
    group_options = User.uniq.pluck(:group)
    return select_tag("filter[group]", options_for_select([""] + group_options), class: "filter_select")
  end
  
  def class_select_filter
    class_options = User::Brother::MitInfo.uniq.pluck("year").sort.reverse
    return select_tag("filter[class]", options_for_select([""] + class_options), class: "filter_select")
  end
  
  def house_select_filter
    return select_tag("filter[house]", options_for_select(["", "True", "False"]), class: "filter_select")
  end
  
  def admin_select_filter
    group_options = User.uniq.pluck(:chicken)
    return select_tag("filter[admin]", options_for_select(group_options), class: "filter_select")
  end
  
  ######################Edit.html.erb#########################
  #Helpers for fields on edit page
  def active_kerberos(user)
    return !user.mit_ldap.nil?
  end
  
  def get_passwd_field(user, f)
    val = (user.shadow.nil?)?"":"~"
    out = f.password_field(:password, value: val)
    return out
  end
  
  #Generates select boxes for brother information
  #@param f_dke: form object for user::brother::dke_info
  #@param dke_info: dke_info instance for selected user
  def brother_info_select(user, f)
    bro = user.brother
    brother_list = User::Brother.name_brother_id_map
    if bro.nil?
      out = select_tag("year_brother", options_for_select(brother_list), class: "year_select")
      out += '<div class="btn usr_sel_yr" id="brother">Select</div>
              <div class="btn clear hidden" id="brother">Clear</div><br>'.html_safe
      out += f.select(:brother_id, [], {}, {class: "hidden", id: "select_brother"})
    else
      year_options = options_for_select(brother_list, brother_list[bro.mit_info.year].to_s)
      brother_options = options_for_select(brother_list[bro.mit_info.year], selected: bro.id)
      out = select_tag("year_brother", year_options, class: "year_select")
      out += '<div class="btn usr_sel_yr" id="brother">Select</div>
              <div class="btn clear" id="brother">Clear</div><br>'.html_safe
      out += f.select(:brother_id, brother_options, {}, {id: "select_brother"})
    end
    return out
  end
  
end
