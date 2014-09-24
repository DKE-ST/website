module Chapter::ResidencesHelper
  
  def get_occupants(room)
    results = []
    room.occupants.each do | occupant |
      results << link_to(occupant.brother.full_name , "#{brothers_path}/#{occupant.brother.id}")
    end
    return results.join(", ").html_safe
  end
  
  def counter(inc)
    @counter = 0 if @counter.nil?
    @counter += inc
    return @counter
  end
  
  def occupant_fields(capacity, occupant_ids, name = nil)
    name = "occupants" if name.nil?
    brother_list = User::Brother.name_dke_info_id_map
    out = "".html_safe
    for i in 0..capacity-1
      if i < occupant_ids.length
        occupant_options = grouped_options_for_select(brother_list, selected=occupant_ids[i])
      else
        occupant_options = grouped_options_for_select(brother_list)
      end
      out += select_tag("chapter_residence[#{name}][#{i}]", occupant_options, class:"chosen-select") + "<br>".html_safe
    end
    return out
  end
  
end
