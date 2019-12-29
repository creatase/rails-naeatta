require "rails_helper"

RSpec.describe "Following", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, name: "Sterling Archer", email: "duchess@example.gov") }
  let(:follow) { FactoryBot.create(:relationship, follower_id: user.id, followed_id: other_user.id) }
  let(:followed) { FactoryBot.create(:relationship, follower_id: other_user.id, followed_id: user.id) }

  before do
    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end

  describe "フォロー中一覧画面" do
    example "フォロー中のユーザーが表示される" do
      follow
      visit following_user_path(user)
      expect(user.following).to_not be_empty
      expect(page).to have_link user.following.count.to_s + "フォロー"
      user.following.each do |follow_user|
        expect(page).to have_link follow_user.name, href: user_path(follow_user)
      end
    end
  end

  describe "フォロワー一覧画面" do
    example "フォロワーが表示される" do
      followed
      visit followers_user_path(user)
      expect(user.followers).to_not be_empty
      expect(page).to have_link user.followers.count.to_s + "フォロワー"
      user.followers.each do |follower|
        expect(page).to have_link follower.name, href: user_path(follower)
      end
    end
  end

  example "フォローできる" do
    visit user_path(other_user)
    expect {
      click_button "フォローする"
    }.to change { user.following.count }.by(1)
  end

  example "フォロー解除できる" do
    follow
    visit user_path(other_user)
    expect {
      click_button "フォローを解除"
    }.to change { user.following.count }.by(-1)
  end
end
