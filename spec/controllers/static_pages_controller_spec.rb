require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  render_views

  let(:base_title) { 'naeatta' }

  describe "GET #home" do
    before do
      get :home
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "タイトルにHomeが含まれる" do
      expect(response.body).to have_title "Home | #{ base_title }"
    end
  end

  describe "GET #help" do
    before do
      get :help
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "タイトルにHelpが含まれる" do
      expect(response.body).to have_title "Help | #{ base_title }"
    end
  end

  describe "GET #about" do
    before do
      get :about
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "タイトルにAboutが含まれる" do
      expect(response.body).to have_title "About | #{ base_title }"
    end
  end

  describe "GET #contact" do
    before do
      get :contact
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "タイトルにContactが含まれる" do
      expect(response.body).to have_title "Contact | #{ base_title }"
    end
  end

end
