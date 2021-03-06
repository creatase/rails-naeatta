require "rails_helper"

RSpec.describe "Users Edit", type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe "ログイン時" do
    example "有効な情報の場合、更新が成功する" do
      visit login_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"

      visit edit_user_path(user)
      fill_in "名前", with: "Foo Bar"
      fill_in "メールアドレス", with: "foo@bar.com"
      fill_in "パスワード", with: ""
      fill_in "パスワード（確認用)", with: ""
      attach_file "ユーザーアイコン", "#{Rails.root}/spec/factories/icon_image.png"
      click_button "更新"

      expect(current_path).to eq user_path(user)
      expect(page).to have_content "プロフィールが更新されました"
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
      user_b = FactoryBot.create(:user, name: "user_b", email: "user_b@mail.com")
      visit login_path
      fill_in "メールアドレス", with: user_a.email
      fill_in "パスワード", with: user_a.password
      click_button "ログイン"

      visit edit_user_path(user_b)
      expect(current_path).to eq root_path
      expect(page).to_not have_css ".alert"
    end
  end
end
