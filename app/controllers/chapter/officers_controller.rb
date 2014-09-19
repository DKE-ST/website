class Chapter::OfficersController < AuthenticationController
  
  def index
    @officers = Chapter::Officer.list_all
  end
  
  def edit
    @officer = Chapter::Officer.find(params[:id])
  end
  
  def update
    @officer = Chapter::Officer.find(params[:id])
    if @officer.update_attributes(officer_params(params))
      flash[:success] = "Officer has been updated"
      redirect_to officers_path
    else
      render 'edit'
    end
  end
  
  def update_contacts
     if Chapter::Officer.update_contacts(update_contacts_params(params))
       flash[:success] = "Contacts Updated"
     end
     redirect_to officers_url
  end
  
 private
 
 def officer_params(params)
   return params.require(:chapter_officer).permit(:name, :title, :dke_info_id, :disp, :contact)
 end
 
  def update_contacts_params(params)
    return params.require(:officer)
  end
  
end
