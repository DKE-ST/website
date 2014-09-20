class Chapter::OfficersController < AuthenticationController
  
  def create
    @officer = Chapter::Officer.new(officer_params(params))
    if @officer.valid?
      @officer.save
      flash[:success] = "Officer created"
      redirect_to officers_path
    else
      render 'new'
    end
  end
  
  def destroy
    @officer = Chapter::Officer.find(params[:id])
    @officer.destroy
    flash[:success] = "Officer destroyed"
    redirect_to officers_path
  end
  
  def edit
    @officer = Chapter::Officer.find(params[:id])
  end
  
  def index
    @officers = Chapter::Officer.list_all
  end
  
  def mass_edit
    @officers = Chapter::Officer.select("id, name, title, position, dke_info_id").order("position")
    @brothers = User::Brother.name_dke_info_id_map
  end
  
  def mass_update
    Chapter::Officer.mass_update(params.require(:officers))
    flash[:success] = "Officers updated"
    redirect_to officers_path
    
  end
  
  def new
    @officer = Chapter::Officer.new
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
