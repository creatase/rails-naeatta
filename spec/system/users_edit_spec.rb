require "rails_helper"

RSpec.describe "Users Edit", type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    activate(user)
  end

  describe "ログイン時" do
    example "有効な情報の場合、更新が成功する" do
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "ログイン"

      visit edit_user_path(user)
      fill_in "Name", with: "Foo Bar"
      fill_in "Email", with: "foo@bar.com"
      fill_in "Password", with: ""
      fill_in "Confirmation", with: ""
      click_button "更新"

      expect(current_path).to eq user_path(user)
      expect(page).to have_content "Profile updated"
    end
  end

  describe "ログアウト時" do
    example "ログイン画面にリダイレクトする" do
      visit edit_user_path(user)
      expect(current_path).to eq login_path
      expect(page).to have_content "ログインしてください"
    end
  end

  describe "異なるユーザーでログイン" do
    example "別ユーザーの編集ページへのアクセスはホーム画面へリダイレクトされる" do
      user_a = FactoryBot.create(:user, name: "user_a", email: "user_a@mail.com")
      activate(user_a)
      user_b = FactoryBot.create(:user, name: "user_b", email: "user_b@mail.com")
      activate(user_a)
      visit login_path
      fill_in "Email", with: user_a.email
      fill_in "Password", with: user_a.password
      click_button "ログイン"

      visit edit_user_path(user_b)
      expect(current_path).to eq root_path
      expect(page).to_not have_css ".alert"
    end
  end
end
