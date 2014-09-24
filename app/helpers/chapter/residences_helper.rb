module Chapter::ResidencesHelper
  
  #Method for keeping trach of when to insert <tr> and </tr> tags in index.html.erb
  def counter(inc)
    @counter = 0 if @counter.nil?
    @counter += inc
    return @counter
  end
  
  #Returns a string containing all of the occupants of room
  def get_occupants(room)
    results = []
    room.occupants.each do | occupant |
      results << link_to(occupant.brother.full_name , "#{brothers_path}/#{occupant.brother.id}")
    end
    return results.join(", ").html_safe
  end
  
  #Returns occuupan select fields for a given room
  #@param capacity: int
  #@param occupant_ids: array (ex. [id1, id2, ...])
  #@param name: (optional) string, default: "occupant"
  def occupant_fields(capacity, occupant_ids, name = "occupants")
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
