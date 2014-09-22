module Chapter::ResidencesHelper
  
  def get_occupants(room)
    results = []
    room.occupants.each do | occupant |
      results << link_to(occupant.brother.full_name , "#{brothers_path}/#{occupant.brother.id}")
    end
    return results.join(", ").html_safe
  end
  
end
