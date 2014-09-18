class Chapter::OfficersController < AuthenticationController
  
  def index
    @officers = Chapter::Officer.list_all
  end
  
  def edit
    @officer = Chapter::Officer.find(params[:id])
  end
  
  def update_contacts
     if Chapter::Officer.update_contacts(update_contacts_params(params))
       flash[:success] = "Contacts Updated"
     end
     redirect_to officers_url
  end
  
 private
 
  def update_contacts_params(params)
    return params.require(:officer)
  end
  
end
