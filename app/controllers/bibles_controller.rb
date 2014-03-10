class BiblesController < AuthController
  
  def index
    @structure = Bible.get_new_bibles
  end
  
  ###### Used for users uploading bibles  ######
  
  def add_bible
    @new_bible = Bible.new
  end
  
  def new_bible
    @new_bible = Bible.new(new_bible_params)
    render "add_bible" unless @new_bible.valid?
  end
  
  def upload_bible
    @new_bible = Bible.new(new_bible_params)
    @new_bible.uname = @me.uname
    if !@new_bible.valid?
      render "add_bible"
    elsif !@new_bible.create(uploaded_file)
      render "new_bible"
    else
      flash[:success] = "Bible uploaded successfully.  Awaiting confirmation from Broporn"
      redirect_to root_url
    end
  end
  
  
 private
 
 def new_bible_params
   return params.require(:bible).permit(:class_num,:year,:semester)
 end
 
 def uploaded_file
   return params.require(:bible).permit(:material)
 end
  
end
