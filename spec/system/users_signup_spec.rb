require "rails_helper"

RSpec.describe "Users Signup", type: :system do
  describe "無効な情報で登録ボタンを押下する" do
    it "エラー内容が表示される" do
      visit signup_path
      fill_in "名前", with: ""
      fill_in "メールアドレス", with: "user@invalid"
      fill_in "パスワード", with: "foo"
      fill_in "パスワード（確認用)", with: "bar"

      click_button "登録"

      expect(page).to have_current_path "/signup"

      expect(page).to have_css ".field_with_errors"
      expect(page).to have_css "#error_explanation"

      expect(page).to have_content "名前を入力してください"
      expect(page).to have_content "メールアドレスは不正な値です"
      expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
      expect(page).to have_content "パスワードは6文字以上で入力してください"
    end
  end

  describe "有効な情報で登録ボタンを押下する" do
    it "ユーザー詳細画面が表示される" do
      visit signup_path
      fill_in "名前", with: "Example User"
      fill_in "メールアドレス", with: "user@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード（確認用)", with: "password"

      click_button "登録"
      user = User.last

      expect(current_path).to eq user_path(user)
      expect(page).to have_content "naeatta!へようこそ!"
      expect(page).to have_selector "a", text: "ログアウト"
    end
  end
end
