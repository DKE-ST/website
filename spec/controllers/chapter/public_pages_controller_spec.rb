require 'rails_helper'

RSpec.describe Chapter::PublicPagesController, :type => :controller do  
  describe "GET #show" do
    it "renders the :show view" do
      get :show, id: FactoryGirl.create(:chapter_public_pages)
      response.should render_template :show
    end
  end
end
