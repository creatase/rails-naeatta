require "rails_helper"

RSpec.describe Relationship, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, name: "Sterling Archer", email: "duchess@example.gov") }
  let(:relationship) { FactoryBot.create(:relationship, follower_id: user.id, followed_id: other_user.id) }

  describe "２ユーザーが存在している時" do
    example "バリデーションを通す" do
      expect(relationship.valid?).to be_truthy
    end
  end

  describe "フォローユーザーが存在していない時" do
    example "バリデーションを通さない" do
      relationship.followed_id = nil
      expect(relationship.valid?).to be_falsey
    end
  end

  describe "フォロワーユーザーが存在していない時" do
    example "バリデーションを通さない" do
      relationship.follower_id = nil
      expect(relationship.valid?).to be_falsey
    end
  end
end
