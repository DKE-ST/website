require 'rails_helper'

RSpec.describe Chapter::BrothersController, :type => :controller do
  before :all do
    FactoryGirl.create(:user, uname: "river", group: "dkealum", chicken: "brochicken")
  end
  
  after :all do
    User.first.destroy
  end
  
  describe "GET #index" do
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  
  describe "GET #show" do
    it "assigns the requested brother to @brother" do
      brother = FactoryGirl.create(:user_brother)
      get :show, id: brother
      assigns(:brother).should eq(brother)
    end
    
    it "renders the :show view" do
      get :show, id: FactoryGirl.create(:user_brother)
      response.should render_template :show
    end
  end
  
  describe "GET #edit" do
    it "renders the :edit view" do
      request.session[:uname] = "river"
      get :edit, id: FactoryGirl.create(:user_brother)
      response.should render_template :edit
    end
    
    it "redirects to index view when not logged in" do
      request.session[:uname] = nil
      get :edit, id: FactoryGirl.create(:user_brother)
      response.should redirect_to root_url
    end
    
    it "redirects to index view when logged in as different user" do
      FactoryGirl.create(:user, uname: "simon", group: "dkealum", chicken: "")
      request.session[:uname] = "simon"
      get :edit, id: FactoryGirl.create(:user_brother)
      response.should redirect_to brother_url
    end
  end
  
  describe "GET #new" do
    it "when not logged in redirects to root_path" do 
      request.session[:uname] = nil
      get :new
      request.should redirect_to root_path
    end
    it "assigns a new brother to @brother" do
      request.session[:uname] = "river"
      get :new
      assigns(:brother).to_json.should eq(User::Brother.new.to_json)
    end
    
    it "renders the :new view" do
      request.session[:uname] = "river"
      get :new
      response.should render_template :new
    end
  end
  
  describe "POST #create" do
    context "when not logged in" do
      before :each do
        request.session[:uname] = nil
      end
      
      it "should not add brother" do
        expect {
          post :create, user_brother: FactoryGirl.attributes_for(:invalid_user_brother)
        }.to_not change(User::Brother, :count)
      end
      
      it "redirects to root_path" do 
        post :create, user_brother: FactoryGirl.attributes_for(:user_brother_full)
        request.should redirect_to root_path
      end
    end
    
    context "with valid attributes" do
      before :each do
        request.session[:uname] = "river"
      end
      
      it "creates a new brother" do
        expect {
          post :create, user_brother: FactoryGirl.attributes_for(:user_brother_full)
        }.to change(User::Brother, :count).by(1)
      end
      
      it "redirects to the new brother" do
        post :create, user_brother: FactoryGirl.attributes_for(:user_brother_full)
        response.should redirect_to "#{brothers_path}/#{User::Brother.last.id}"
      end
      
      it "redirects to new brother page if new in :little_ids" do
        attrs = FactoryGirl.attributes_for(:user_brother_full)
        attrs[:dke_info][:little_ids] = {"0" => "new"}
        post :create, user_brother: attrs
        response.should redirect_to "#{new_brother_path}?big_id=#{User::Brother.last.id}"
      end
    end
    
    context "with invalid attributes" do
      before :each do
        request.session[:uname] = "river"
      end
      
      it "does not save the new brother" do
        expect {
          post :create, user_brother: FactoryGirl.attributes_for(:invalid_user_brother)
        }.to_not change(User::Brother, :count)
      end
      
      it "re-renders the new view" do
        post :create, user_brother: FactoryGirl.attributes_for(:invalid_user_brother)
        response.should render_template :new
      end
    end
  end
  
  describe "PUT #update" do
    before :each do
      @brother = FactoryGirl.create(:user_brother, first_name: "Hoban", last_name: "Washbourne")
      request.session[:uname] = "river"
    end
    
    context "without admin access" do
      before :each do
        request.session[:uname] = nil
      end
      
      it "doesn't change @brother's attributes" do
        put :update, id: @brother, user_brother: FactoryGirl.attributes_for(:user_brother_full)
        @brother.reload
        @brother.first_name.should_not eq("Malcolm")
        @brother.last_name.should eq("Washbourne")
      end
      it "redirects to root_path" do
        put :update, id: @brother, user_brother: FactoryGirl.attributes_for(:invalid_user_brother)
        response.should redirect_to root_path
      end
    end
    
    context "valid attributes" do
      it "located the requested @brother" do
        put :update, id: @brother, user_brother: FactoryGirl.attributes_for(:user_brother_full)
        assigns(:brother).should eq(@brother)
      end
      it "changes @brother's attributes" do
        put :update, id: @brother, user_brother: FactoryGirl.attributes_for(:user_brother_full,
                                                                            first_name: "Malcolm",
                                                                            last_name: "Reynolds")
        @brother.reload
        @brother.first_name.should eq("Malcolm")
        @brother.last_name.should eq("Reynolds")
      end
      
      it "redirects to the updated brother" do
        put :update, id: @brother, user_brother: FactoryGirl.attributes_for(:user_brother_full)
        response.should redirect_to brother_path
      end
      
      it "redirects to new brother page if new in :little_ids" do
        attrs = FactoryGirl.attributes_for(:user_brother_full)
        attrs[:dke_info][:little_ids] = {"0" => "new"}
        put :update, id: @brother, user_brother: attrs
        response.should redirect_to "#{new_brother_path}?big_id=#{@brother.id}"
      end
    end
    
    context "invalid attributes" do
      it "locates requested @brother" do
        put :update, id: @brother, user_brother: FactoryGirl.attributes_for(:invalid_user_brother)
        assigns(:brother).should eq(@brother)
      end
      it "doesn't change @brother's attributes" do
        put :update, id: @brother, user_brother: FactoryGirl.attributes_for(:user_brother_full,
                                                                            first_name: "Malcolm",
                                                                            last_name: nil)
        @brother.reload
        @brother.first_name.should_not eq("Malcolm")
        @brother.last_name.should eq("Washbourne")
      end
      it "re-renders edit view" do
        put :update, id: @brother, user_brother: FactoryGirl.attributes_for(:invalid_user_brother)
        response.should render_template :edit
      end
    end
  end
  
  describe "DELETE #destroy" do
    before :each do
      @brother = FactoryGirl.create(:user_brother)
      request.session[:uname] = "river"
    end
    
    context "with admin access" do
      it "deletes the brother" do
        expect {
          delete :destroy, id: @brother
        }.to change(User::Brother, :count).by(-1)
      end
      it "redirects to brothers#index" do
        delete :destroy, id: @brother
        response.should redirect_to brothers_path
      end
    end
    
    context "without admin access" do
      before :each do
        @brother = FactoryGirl.create(:user_brother)
        request.session[:uname] = nil
      end
    
      it "doesn't delete the brother" do
        expect {
          delete :destroy, id: @brother
        }.to_not change(User::Brother, :count)
      end
      
      it "redirects to root_path" do
        delete :destroy, id: @brother
        response.should redirect_to root_path
      end
    end
  end
end
