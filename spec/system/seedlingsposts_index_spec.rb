require "rails_helper"

RSpec.describe "Seedlingsposts index", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, name: "Sterling Archer", email: "duchess@example.gov") }
  let(:post) { FactoryBot.create(:seedlingspost, user: user, item: "スイカ") }
  let(:other_users_post) { FactoryBot.create(:seedlingspost, user: other_user, item: "トマト") }
  let(:follow) { FactoryBot.create(:relationship, follower_id: user.id, followed_id: other_user.id) }
  let(:followed) { FactoryBot.create(:relationship, follower_id: other_user.id, followed_id: user.id) }

  describe "ログアウトでアクセス" do
    example "ログイン画面へリダイレクトする" do
      visit seedlingsposts_path
      expect(current_path).to eq login_path
    end
  end

  describe "ログインでアクセス" do
    before do
      visit login_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
    end

    example "苗情報一覧画面を表示する" do
      visit seedlingsposts_path
      expect(current_path).to eq seedlingsposts_path
    end

    example "ログインユーザーの投稿を表示する" do
      post
      visit seedlingsposts_path
      expect(page).to have_content "スイカ"
      expect(page).to have_link user.name, href: user_path(user)
    end
    example "フォロー中のユーザーの投稿を表示する" do
      other_users_post
      follow
      visit seedlingsposts_path
      expect(page).to have_content "トマト"
      expect(page).to have_link other_user.name, href: user_path(other_user)
    end
    example "フォローしていないユーザーの投稿を表示する" do
      other_users_post
      visit seedlingsposts_path
      expect(page).to have_content "トマト"
      expect(page).to have_link other_user.name, href: user_path(other_user)
    end
  end
end
