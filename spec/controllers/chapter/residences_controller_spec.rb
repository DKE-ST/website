require 'rails_helper'

RSpec.describe Chapter::ResidencesController, :type => :controller do
  before :all do
    FactoryGirl.create(:user, uname: "simon", group: "dkeactive", chicken: "broporn")
    user = FactoryGirl.create(:user, uname: "river", group: "dkeactive", chicken: "")
    FactoryGirl.create(:user_brother, user_id: user.id)
    FactoryGirl.create(:chapter_officer, name: "beta", dke_info_id: user.brother.dke_info.id)
  end
  
  after :all do
    User.destroy_all
    User::Brother.destroy_all
    Chapter::Officer.destroy_all
  end
  
  context "public access for" do
    it "GET #house" do
      request.session[:uname] = nil
      get :house
      response.should render_template :house
    end
    it "GET #tour" do
      request.session[:uname] = nil
      get :tour
      response.should render_template :tour
    end
  end
  
  describe "GET #index" do
    it "renders the :index view if authenticated" do
      request.session[:uname] = "simon"
      get :index
      response.should render_template :index
    end
    
    it "redirects to home page if not broporn" do
      request.session[:uname] = "river"
      get :index
      response.should redirect_to root_path
    end
  end
  
  describe "GET #show" do
    it "assigns the requested residence to @room" do
      room = FactoryGirl.create(:chapter_residence)
      get :show, id: room
      assigns(:room).should eq(room)
    end
    
    it "renders the :show view" do
      get :show, id: FactoryGirl.create(:chapter_residence)
      response.should render_template :show
    end
  end
  
  describe "GET #edit" do
    it "when authenticated renders the :edit view" do
      request.session[:uname] = "simon"
      get :edit, id: FactoryGirl.create(:chapter_residence)
      response.should render_template :edit
    end
    
    it "redirects to home page when not authenticated" do
      request.session[:uname] = "river"
      get :edit, id: FactoryGirl.create(:chapter_residence)
      response.should redirect_to root_url
    end
  end
  
  describe "GET #room_picks" do
    it "should render #room_picks page for beta or sigma" do
      request.session[:uname] = "river"
      get :room_picks
      response.should render_template :room_picks
    end
    
    it "should redirect to home page for anyone else" do
      request.session[:uname] = "simon"
      get :room_picks
      response.should redirect_to root_path
    end
  end

  describe "PUT #update" do
    before :each do
      @residence = FactoryGirl.create(:chapter_residence, name: "Serenity", floor: 2)
      request.session[:uname] = "simon"
    end
    
    context "without admin access" do
      before :each do
        request.session[:uname] = nil
      end
      
      it "doesn't change @residence's attributes" do
        put :update, id: @residence, chapter_residence: FactoryGirl.attributes_for(:chapter_residence, name: "Galactica")
        @residence.reload
        @residence.name.should_not eq("Galactica")
        @residence.floor.should eq(2)
      end
      it "redirects to root_path" do
        put :update, id: @residence, chapter_residence: FactoryGirl.attributes_for(:invalid_user_brother)
        response.should redirect_to root_path
      end
    end
    
    context "valid attributes" do
      it "located the requested @residence" do
        put :update, id: @residence, chapter_residence: FactoryGirl.attributes_for(:chapter_residence)
        assigns(:room).should eq(@residence)
      end
      it "changes @residence's attributes" do
        put :update, id: @residence, chapter_residence: FactoryGirl.attributes_for(:chapter_residence,
                                                                            name: "Galactica",
                                                                            floor: 4)
        @residence.reload
        @residence.name.should eq("Galactica")
        @residence.floor.should eq(4)
      end
      
      it "redirects to the updated brother" do
        put :update, id: @residence, chapter_residence: FactoryGirl.attributes_for(:chapter_residence)
        response.should redirect_to residences_path
      end
    end
    
    context "invalid attributes" do
      it "locates requested @residence" do
        put :update, id: @residence, chapter_residence: FactoryGirl.attributes_for(:invalid_chapter_residence)
        assigns(:room).should eq(@residence)
      end
      it "doesn't change @residence's attributes" do
        put :update, id: @residence, chapter_residence: FactoryGirl.attributes_for(:chapter_residence,
                                                                                  name: nil,
                                                                                  floor: 4)
        @residence.reload
        @residence.name.should eq("Serenity")
        @residence.floor.should_not eq(4)
      end
      it "re-renders edit view" do
        put :update, id: @residence, chapter_residence: FactoryGirl.attributes_for(:invalid_chapter_residence)
        response.should render_template :edit
      end
    end
  end
  
  describe "POST #mass_update" do
    it "redirects to home page when not authenticated" do
      request.session[:uname] = "simon"
      post :mass_update
      response.should redirect_to root_url
    end
  end
end
