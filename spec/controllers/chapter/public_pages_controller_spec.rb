require 'rails_helper'

RSpec.describe Chapter::PublicPagesController, :type => :controller do
  before :all do
    FactoryGirl.create(:user, uname: "river", group: "dkealum", chicken: "brochicken")
  end
  
  after :all do 
    User.first.destroy
  end
  
  it "GET #contact renders the :contact view" do
      get :contact
      response.should render_template :contact
    end
  
  describe "GET #show" do
    it "assigns the requested public_page to @content" do
      @content = FactoryGirl.create(:chapter_public_page)
      get :show, id: @content.pname
      assigns(:content).should eq(@content)
    end
    
    it "renders the :show view" do
      get :show, id: FactoryGirl.create(:chapter_public_page)
      response.should render_template :show
    end
  end
  
  describe "GET #edit" do
    it "renders the :edit view" do
      request.session[:uname] = "river"
      get :edit, id: FactoryGirl.create(:chapter_public_page).pname
      response.should render_template :edit
    end
    
    it "redirects to index view when not logged in" do
      request.session[:uname] = nil
      get :edit, id: FactoryGirl.create(:chapter_public_page).pname
      response.should redirect_to public_page_path
    end
  end
  
  describe "PUT #update" do
    before :each do
      @content = FactoryGirl.create(:chapter_public_page, title: "About Test")
      request.session[:uname] = "river"
    end
    
    context "without admin access" do
      before :each do
        request.session[:uname] = nil
      end
      
      it "doesn't change @content's attributes" do
        put :update, id: @content.pname, chapter_public_page: FactoryGirl.attributes_for(:chapter_public_page)
        @content.reload
        @content.title.should eq("About Test")
      end
      it "redirects to root_path" do
        put :update, id: @content.pname, chapter_public_page: FactoryGirl.attributes_for(:chapter_public_page)
        response.should redirect_to public_page_path
      end
    end
    
    context "valid attributes" do
      it "located the requested @content" do
        put :update, id: @content.pname, chapter_public_page: FactoryGirl.attributes_for(:chapter_public_page)
        assigns(:content).should eq(@content)
      end
      
      it "changes @content's attributes" do
        put :update, id: @content.pname, chapter_public_page: FactoryGirl.attributes_for(:chapter_public_page,
                                                                                  title: "Test Letter")
        @content.reload
        @content.title.should eq("Test Letter")
      end
      
      it "redirects to the updated page" do
        put :update, id: @content.pname, chapter_public_page: FactoryGirl.attributes_for(:chapter_public_page)
        response.should redirect_to public_page_path
      end
    end
    
    context "invalid attributes" do
      it "locates requested @content" do
        put :update, id: @content.pname, chapter_public_page: FactoryGirl.attributes_for(:invalid_chapter_public_page)
        assigns(:content).should eq(@content)
      end
      it "doesn't change @content's attributes" do
        put :update, id: @content.pname, chapter_public_page: FactoryGirl.attributes_for(:invalid_chapter_public_page)
        @content.reload
        @content.title.should eq("About Test")
      end
      it "re-renders edit view" do
        put :update, id: @content.pname, chapter_public_page: FactoryGirl.attributes_for(:invalid_chapter_public_page)
        response.should render_template :edit
      end
    end
  end
end
