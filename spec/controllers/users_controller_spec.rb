require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(login_url)

      log_in_as(user)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #following" do
    it "returns http success" do
      get :following, params: { id: user.id }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(login_url)

      log_in_as(user)
      get :following, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
  describe "GET #followers" do
    it "returns http success" do
      get :followers, params: { id: user.id }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(login_url)

      log_in_as(user)
      get :followers, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
end
