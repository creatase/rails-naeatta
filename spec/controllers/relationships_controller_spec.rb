require "rails_helper"

RSpec.describe RelationshipsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, name: "Sterling Archer", email: "duchess@example.gov") }
  let(:follow) { FactoryBot.create(:relationship, follower_id: user.id, followed_id: other_user.id) }

  it "フォローにはログインが必要" do
    expect {
      post :create
    }.to change { Relationship.count }.by(0)
    expect(response).to redirect_to login_path
  end

  it "フォロー解除にはログインが必要" do
    follow
    expect {
      delete :destroy, params: { id: follow.id }
    }.to change { Relationship.count }.by(0)
    expect(response).to redirect_to login_path
  end
end
