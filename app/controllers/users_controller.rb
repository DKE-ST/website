class UsersController < AuthController
  before_action :auth_user
  skip_before_action :auth_user, only: [:ch_pwd, :update_pwd]
  skip_before_action :logged_in, only: [:ch_pwd, :update_pwd]
  before_action :has_pwd, only: [:ch_pwd, :update_pwd]
  
  def index
    @affiliates = Apache.read["dkeaffil"] if Apache.read.include? "dkeaffil"
    @brothers= Hash.new
    class_map = BrothersDke.select("uname, p_class").order("p_class DESC")
    class_map.each do |user|
      @brothers[user.p_class] = Array.new([]) if !@brothers.include? user.p_class
      @brothers[user.p_class] << [BrothersPersonal.find_by(uname: user.uname).full_name, user.uname]
    end
    @brothers.each do |key, value|
      value.sort!
    end
  end
  
  def new
    @user = Users.new
  end
  
  def show
    @user = Users.new(params[:id])
  end
  
  def add_pledges
    #puts params[:pledges]
    @pledges = Hash.from_xml(params[:pledges])["hash"] unless params[:pledges].blank?
    if params[:commit] == "commit"
      Users.add_class(@pledges)
      redirect_to users_url
      return
    end
    #puts "Test:#{@pledges.to_s}"
    #puts @pledges.blank?
    @pledges = Hash.new if @pledges.blank?
    if params["remove"]
      @pledges.delete(params["remove"])
    elsif !params[:kerberos].blank?
      tmp_user = Users.new(params[:kerberos])
      if tmp_user.personal
        flash[:fail] = "#{tmp_user.uname} already exist in databases"
      elsif tmp_user.ldap
        pledge ={"first_name" => tmp_user.ldap.givenName}
        pledge["last_name"] = tmp_user.ldap.sn
        pledge["year"] = tmp_user.ldap.year
        @pledges[tmp_user.uname] = pledge
      else
        flash[:fail] = "#{tmp_user.uname} does not exist"
      end
    end
    render "add_pledges"
  end

  def create
    @user = Users.new(params[:users])
    status = @user.create
    if status.nil?
      redirect_to users_url
    else
      flash[:fail] = status unless status.empty?
      render "new"
    end
  end

  def update
    @user = Users.new(params[:id])
    #use if no params used to grant/remove server acess
    if params[:users].nil?
      if Apache.exists(@user.uname)
        Apache.rm(@user.uname)       
        flash[:success] = "#{@user.uname}: server access removed"
      else
        if params[:password].nil?
          flash[:success] = "#{@user.uname}: given server access"
          Apache.add(@user.uname, "dkebro", @user.dke.p_class.to_s)
        else
          @user.password = params[:password]
          unless @user.valid?
            flash[:fail] = @user.errors.full_messages.join(", ")
          else
            Apache.add(@user.uname, "dkebro", @user.dke.p_class.to_s, @user.password)
            flash[:success] = "#{@user.uname}: given server access"
          end
        end
      end
      redirect_to users_url
    elsif @user.group != "dkeaffil"
      if @user.update(params)
        flash[:success] = "Information updated"
        redirect_to users_url
      else
        render "show"
      end
    else
      if @user.update_afil(params)
        flash[:success] = "Information updated"
        redirect_to users_url
      else
        render "show"
      end
    end
  end
  
  def destroy
    @user = Users.new(params[:id])
    @user.destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  def ch_pwd
    @user = Users.new
  end
  
  def update_pwd
    fail = Array.new([])
    fail << "Passwords do not match" if params['password1']!=params['password2']
    fail << "Passwords must be at least 8 characters" if params['password1'].length < 8
    fail <<  "Passwords must cannot contain white space characters" if params['password1'].length =~ /\s/
    unless fail.empty?
      flash[:fail] = fail.join('<br>').html_safe
    else
      Apache.password(@me.uname,params['password1'])
      flash[:success] = "Password Changed Sucessfully"
      redirect_to root_path
    end
  end
  
  private
  
  def auth_user
    unless @me.in_group("brochicken")
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    end
  end
  
  def has_pwd
    if @me.uname.nil?
      flash[:error] = "You do not have acess to this page"
      redirect_to root_url
    elsif !@me.pwd?
      flash[:error] = "Your password is set through your kerberos"
      redirect_to root_url
    end
  end
end
