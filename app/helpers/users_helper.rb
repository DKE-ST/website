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
  
  #Returns whether user instance has an active mit kerberos account associated with it
  #@param user: instance of User
  #@return boolean
  def active_kerberos(user)
    return !user.mit_ldap.nil?
  end
  
  #Returns password field for user
  #@param user: instance of User
  #@return password form field
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
    brother_list[""] << ["New Brother", "new"]
    if bro.nil?
      brother_options = grouped_options_for_select(brother_list)
    else
      brother_options = grouped_options_for_select(brother_list, selected: bro.id)
    end
    return f.select(:brother_id, brother_options, {}, class:"chosen-select")
  end
  
end
