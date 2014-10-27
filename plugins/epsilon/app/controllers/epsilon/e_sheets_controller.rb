class Epsilon::ESheetsController < AuthenticationController
  skip_before_action :logged_in, only: [:public_sheet, :public_sign_up]
  
  def auth_sheet
    @week_meals = Epsilon::ESheet.get_week
    @e_count = Epsilon::ESheet.track_progress
  end
  
  def auth_sign_up
    msg = Epsilon::ESheet.sign_up(sign_up_params(params), @me)
    unless msg[0]
      flash[:error] = msg[1]
    end
    redirect_to e_sheet_path
  end
  
  def public_sheet
    @week_meals = Epsilon::ESheet.get_week
    @e_count = Epsilon::ESheet.track_progress
    render layout: false
  end
  
  def public_sign_up
    user = User.find_by(mit_id: params[:mit_id])
    if params[:mit_id].nil? || user.nil?
      flash[:error] = "Invalid ID number"
    else
      msg = Epsilon::ESheet.sign_up(sign_up_params(params), user)
      unless msg[0]
        flash[:error] = msg[1]
      end
    end
    redirect_to public_sheet_path
  end
  
 private
  
  def sign_up_params(params)
    params.require(:meal).permit(:id,:action)
  end
  
end
