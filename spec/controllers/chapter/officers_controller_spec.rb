require 'rails_helper'

RSpec.describe Chapter::OfficersController, :type => :controller do
  before :all do
    user = FactoryGirl.create(:user, uname: "river", group: "dkeactive", chicken: "brochicken")
    FactoryGirl.create(:user_brother, user_id: user.id)
    FactoryGirl.create(:chapter_officer, name: "beta", dke_info_id: user.brother.dke_info.id)
  end
  
  after :all do
    User.destroy_all
    User::Brother.destroy_all
    Chapter::Officer.destroy_all
  end
  
  describe "GET #index" do
    it "renders the :index view if authenticated" do
      request.session[:uname] = "river"
      get :index
      response.should render_template :index
    end
    
    it "redirects to home page if not authenticated" do
      get :index
      response.should redirect_to root_path
    end
  end
  
  describe "GET #edit" do
    it "when authenticated renders the :edit view" do
      request.session[:uname] = "river"
      get :edit, id: FactoryGirl.create(:chapter_officer)
      response.should render_template :edit
    end
    
    it "redirects to index view when not authenticated" do
      request.session[:uname] = nil
      get :edit, id: FactoryGirl.create(:chapter_officer)
      response.should redirect_to root_url
    end
  end
  
  describe "GET #new" do
    it "when not logged in redirects to root_path" do 
      request.session[:uname] = nil
      get :new
      request.should redirect_to root_path
    end
    
    it "assigns a new brother to @officer" do
      request.session[:uname] = "river"
      get :new
      assigns(:officer).to_json.should eq(Chapter::Officer.new.to_json)
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
      
      it "should not add officer" do
        expect {
          post :create, chapter_officer: FactoryGirl.attributes_for(:chapter_officer)
        }.to_not change(User::Brother, :count)
      end
      
      it "redirects to root_path" do 
        post :create, chapter_officer: FactoryGirl.attributes_for(:chapter_officer)
        request.should redirect_to root_path
      end
    end
    
    context "with valid attributes" do
      before :each do
        request.session[:uname] = "river"
      end
      
      it "creates a new officer" do
        expect {
          post :create, chapter_officer: FactoryGirl.attributes_for(:chapter_officer)
        }.to change(Chapter::Officer, :count).by(1)
      end
      
      it "redirects to the officer#index" do
        post :create, chapter_officer: FactoryGirl.attributes_for(:chapter_officer)
        response.should redirect_to officers_path
      end
    end
    
    context "with invalid attributes" do
      before :each do
        request.session[:uname] = "river"
      end
      
      it "does not save the new officer" do
        expect {
          post :create, chapter_officer: FactoryGirl.attributes_for(:invalid_chapter_officer)
        }.to_not change(Chapter::Officer, :count)
      end
      
      it "re-renders the new view" do
        post :create, chapter_officer: FactoryGirl.attributes_for(:invalid_chapter_officer)
        response.should render_template :new
      end
    end
  end
  
  describe "PUT #update" do
    before :each do
      @officer = FactoryGirl.create(:chapter_officer, name: "kappa", title: "Treasurer")
      request.session[:uname] = "river"
    end
    
    context "without admin access" do
      before :each do
        request.session[:uname] = nil
      end
      
      it "doesn't change @officer's attributes" do
        put :update, id: @officer, chapter_officer: FactoryGirl.attributes_for(:chapter_officer)
        @officer.reload
        @officer.name.should eq("kappa")
        @officer.title.should eq("Treasurer")
      end
      it "redirects to root_path" do
        put :update, id: @officer, chapter_officer: FactoryGirl.attributes_for(:chapter_officer)
        response.should redirect_to root_path
      end
    end
    
    context "valid attributes" do
      it "located the requested @officer" do
        put :update, id: @officer, chapter_officer: FactoryGirl.attributes_for(:chapter_officer)
        assigns(:officer).should eq(@officer)
      end
      it "changes @brother's attributes" do
        put :update, id: @officer, chapter_officer: FactoryGirl.attributes_for(:chapter_officer,
                                                                              name: "sigma",
                                                                              title: "Vice President")
        @officer.reload
        @officer.name.should eq("sigma")
        @officer.title.should eq("Vice President")
      end
      
      it "redirects to the updated brother" do
        put :update, id: @officer, chapter_officer: FactoryGirl.attributes_for(:chapter_officer)
        response.should redirect_to officers_path
      end
    end
    
    context "invalid attributes" do
      it "locates requested @brother" do
        put :update, id: @officer, chapter_officer: FactoryGirl.attributes_for(:invalid_chapter_officer)
        assigns(:officer).should eq(@officer)
      end
      it "doesn't change @officer's attributes" do
        put :update, id: @officer, chapter_officer: FactoryGirl.attributes_for(:invalid_chapter_officer,
                                                                              name: nil,
                                                                              title: "Vice President")
        @officer.reload
        @officer.name.should eq("kappa")
        @officer.title.should_not eq("Vice President")
      end
      it "re-renders edit view" do
        put :update, id: @officer, chapter_officer: FactoryGirl.attributes_for(:invalid_chapter_officer)
        response.should render_template :edit
      end
    end
  end
  
  describe "DELETE #destroy" do
    before :each do
      @officer = FactoryGirl.create(:chapter_officer)
      request.session[:uname] = "river"
    end
    
    context "with admin access" do
      it "deletes the officer" do
        expect {
          delete :destroy, id: @officer
        }.to change(Chapter::Officer, :count).by(-1)
      end
      it "redirects to officers#index" do
        delete :destroy, id: @officer
        response.should redirect_to officers_path
      end
    end
    
    context "without admin access" do
      before :each do
        @officer = FactoryGirl.create(:chapter_officer)
        request.session[:uname] = nil
      end
    
      it "doesn't delete the brother" do
        expect {
          delete :destroy, id: @officer
        }.to_not change(Chapter::Officer, :count)
      end
      
      it "redirects to root_path" do
        delete :destroy, id: @officer
        response.should redirect_to root_path
      end
    end
  end
end
