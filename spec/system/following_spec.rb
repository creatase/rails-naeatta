require "rails_helper"

RSpec.describe "Following", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, name: "Sterling Archer", email: "duchess@example.gov") }
  let!(:follow) { FactoryBot.create(:relationship, follower_id: user.id, followed_id: other_user.id) }
  let!(:followed) { FactoryBot.create(:relationship, follower_id: other_user.id, followed_id: user.id) }

  before do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "ログイン"
  end

  describe "フォロー中一覧画面" do
    example "フォロー中のユーザーが表示される" do
      visit following_user_path(user)
      expect(user.following).to_not be_empty
      expect(page).to have_link user.following.count.to_s + "following"
      user.following.each do |follow_user|
        expect(page).to have_link follow_user.name, href: user_path(follow_user)
      end
    end
  end

  describe "フォロワー一覧画面" do
    example "フォロワーが表示される" do
      visit followers_user_path(user)
      expect(user.followers).to_not be_empty
      expect(page).to have_link user.followers.count.to_s + "followers"
      user.followers.each do |follower|
        expect(page).to have_link follower.name, href: user_path(follower)
      end
    end
  end
end
