module Chapter::OfficersHelper
  
  ############ edit.html.erb & new.html.erb ###################
  
  #Generates select boxes for big brother information
  #@param f_dke: form object for user::brother::dke_info
  #@param dke_info: dke_info instance for selected user
  def officer_select(form, dke_info_id)
    brother_list = User::Brother.name_dke_info_id_map
    big_options = grouped_options_for_select(brother_list, selected=dke_info_id)
    return form.select(:dke_info_id, big_options, {}, class:"chosen-select")
  end
  
end
