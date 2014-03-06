class BiblesController < ApplicationController
  
  def add_bible
    @new_bible = Bible.new
  end
  
  def new_bible
    @new_bible = Bible.new(new_bible_params)
    render "add_bible"
  end
  
  
 private
 
 def new_bible_params
   return params.require(:new_bible).permit(:class,:year,:semester)
 end
  
end
