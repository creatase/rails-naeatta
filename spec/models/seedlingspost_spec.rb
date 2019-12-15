require "rails_helper"

RSpec.describe Seedlingspost, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:seedlingspost, user: user) }

  describe "バリデーション" do
    context "有効な値で登録" do
      it "成功する" do
        expect(post).to be_valid
      end

      it "ユーザーは必須である" do
        post.user_id = nil
        expect(post).to_not be_valid
      end

      it "品目は必須である" do
        post.item = nil
        expect(post).to_not be_valid
      end

      it "規格は必須である" do
        post.product_regulation = nil
        expect(post).to_not be_valid
      end

      it "穂木は必須である" do
        post.scion = nil
        expect(post).to_not be_valid
      end

      it "台木は必須である" do
        post.rootstock = nil
        expect(post).to_not be_valid
      end

      it "本数は必須である" do
        post.count = nil
        expect(post).to_not be_valid
      end

      it "生産地は必須である" do
        post.location = nil
        expect(post).to_not be_valid
      end

      it "発注単位は必須である" do
        post.order_unit = nil
        expect(post).to_not be_valid
      end
    end
  end
end
