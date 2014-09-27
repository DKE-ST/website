require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  before :all do
    FactoryGirl.create(:user, uname: "river", group: "dkeactive", chicken: "brochicken")
  end
  
  after :all do
    User.destroy_all
  end
  
  describe "GET #index" do
    it "redirects to home page when not authenticated" do
      get :index
      response.should redirect_to root_path
    end
    it "renders the :index view when authenticated" do
      request.session[:uname] = "river"
      get :index
      response.should render_template :index
    end
  end
  
  describe "GET #edit" do
    it "renders the :edit view when authenticated" do
      request.session[:uname] = "river"
      get :edit, id: FactoryGirl.create(:user)
      response.should render_template :edit
    end
    it "assigns the requested user to @user" do
      request.session[:uname] = "river"
      user = FactoryGirl.create(:user)
      get :edit, id: user
      assigns(:user).should eq(user)
    end
    it "redirects to root path when not authenticated" do
      get :edit, id: FactoryGirl.create(:user)
      response.should redirect_to root_path
    end
  end
  
  describe "GET #new" do
    it "when not logged in redirects to root_path" do
      get :new
      response.should redirect_to root_path
    end
    it "assigns a new user to @user" do
      request.session[:uname] = "river"
      get :new
      assigns(:user).to_json.should eq(User.new.to_json)
    end
    it "renders the :new view" do
      request.session[:uname] = "river"
      get :new
      response.should render_template :new
    end
  end
  
  describe "POST #create" do
    context "not authenticated" do
      it "should not add user" do
        expect {
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to_not change(User, :count)
      end
      it "redirects to root_path" do
        post :create, user: FactoryGirl.attributes_for(:user)
        response.should redirect_to root_path
      end
    end
    context "valid attributes" do
      before :each do
        request.session[:uname] = "river"
      end
      
      it "creates a new user" do
        expect {
          post :create, user: FactoryGirl.attributes_for(:user)
        }.to change(User, :count).by(1)
      end
      
      it "redirects to the users_path" do
        post :create, user: FactoryGirl.attributes_for(:user)
        response.should redirect_to users_path
      end
      
      it "redirects to new brother page if brother_id == new" do
        post :create, user: FactoryGirl.attributes_for(:user, brother_id: "new")
        response.should redirect_to "#{new_brother_path}?user_id=#{User.last.id}"
      end
    end
    context "invalid attributes" do
      before :each do
        request.session[:uname] = "river"
      end
      
      it "does not save the new user" do
        expect {
          post :create, user: FactoryGirl.attributes_for(:invalid_user)
        }.to_not change(User, :count)
      end
      
      it "re-renders the new view" do
        post :create, user: FactoryGirl.attributes_for(:invalid_user)
        response.should render_template :new
      end
    end
  end
  describe "PUT #update" do
    before :each do 
      @user = FactoryGirl.create(:user, uname: "shepard", mit_id:"123456789")
    end
    context "not authenticated" do
      it "doesn't change @user's attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        @user.reload
        @user.uname.should eq("shepard")
        @user.mit_id.should eq("123456789")
      end
      it "redirects to root_path" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        response.should redirect_to root_path
      end
    end
    context "valid attributes" do
      before :each do
        request.session[:uname] = "river"
      end
      
      it "located the requested @user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        assigns(:user).should eq(@user)
      end
      
      it "changes @user's attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, uname: "wrex", mit_id: "987654321")
        @user.reload
        @user.uname.should eq("wrex")
        @user.mit_id.should eq("987654321")
      end
      
      it "redirects to the users_page" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user)
        response.should redirect_to users_path
      end
      
      it "redirects to new brother page if brother_id == new" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, brother_id: "new")
        response.should redirect_to "#{new_brother_path}?user_id=#{User.last.id}"
      end
    end
    context "invalid attributes" do
      before :each do
        request.session[:uname] = "river"
      end
      
      it "located the requested @user" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user)
        assigns(:user).should eq(@user)
      end
      
      it "doesn't change @user's attributes" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:user, uname: nil, mit_id: "987654321")
        @user.reload
        @user.uname.should eq("shepard")
        @user.mit_id.should_not eq("987654321")
      end
      
      it "re-renders edit view" do
        put :update, id: @user, user: FactoryGirl.attributes_for(:invalid_user)
        response.should render_template :edit
      end
    end
  end
  
  describe "DELETE #destroy" do
    before :each do
      @user = FactoryGirl.create(:user)
    end
    
    context "not authenticated" do
      it "doesn't delete the user" do
        expect {
          delete :destroy, id: @user
        }.to_not change(User, :count)
      end
    end
    
    context "authenticated" do
      it "deletes the user" do
        request.session[:uname] = "river"
        expect {
          delete :destroy, id: @user
        }.to change(User, :count).by(-1)
      end
    end
  end
  
  describe "GET #add_pledges" do
    it "should redirect to root_path when not authenticated" do
      get :add_pledges
      response.should redirect_to root_path
    end
    
    it "should render :add_pledges view when authenticated" do
      request.session[:uname] = "river"
      get :add_pledges
      response.should render_template :add_pledges
    end
  end
  
  describe "POST #create_pledges" do
    it "should reditect to root_path when not authenticated" do
      post :create_pledges, user: {}
      response.should redirect_to root_path
    end
  end
end
