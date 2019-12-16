require "rails_helper"

RSpec.describe SeedlingspostsController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:seedlingspost) { FactoryBot.create(:seedlingspost, user: user) }

  describe "ログアウト時" do
    it "苗情報を投稿できない" do
      post :create, params: {
        seedlingspost: {
          item: "MyText",
          product_regulation: "MyText",
          shipping_date: "2019-12-15",
          scion: "MyText",
          rootstock: "MyText",
          count: 1,
          location: "MyText",
          order_unit: 1,
          remarks: "MyText",
          user_id: user.id,
        },
      }
      expect(response).to redirect_to login_path
    end

    it "苗情報を削除しようとするとログイン画面にリダイレクトする" do
      delete :destroy, params: { id: seedlingspost.id }
      expect(response).to redirect_to login_path
    end
  end
end
