class Chapter::OfficersController < AuthenticationController
  
  def index
    @officers = Chapter::Officer.list_all
  end
  
end
