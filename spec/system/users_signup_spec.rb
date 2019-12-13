require "rails_helper"

RSpec.describe "Users Signup", type: :system do
  before do
    ActionMailer::Base.deliveries.clear
  end

  describe "無効な情報で登録ボタンを押下する" do
    it "エラー内容が表示される" do
      visit signup_path
      fill_in "Name", with: ""
      fill_in "Email", with: "user@invalid"
      fill_in "Password", with: "foo"
      fill_in "Confirmation", with: "bar"

      click_button "登録"

      expect(page).to have_current_path "/signup"

      expect(page).to have_css ".field_with_errors"
      expect(page).to have_css "#error_explanation"

      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Email is invalid"
      expect(page).to have_content "Password confirmation doesn't match Password"
      expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end
  end

  describe "有効な情報で登録ボタンを押下する" do
    let(:email) { "user@example.com" }
    let(:password) { "password" }
    before do
      visit signup_path
      fill_in "Name", with: "Example User"
      fill_in "Email", with: email
      fill_in "Password", with: password
      fill_in "Confirmation", with: password
      click_button "登録"
    end

    it "アカウント有効化メールの確認を促すフラッシュを表示する" do
      expect(page).to have_css ".alert-info", text: "アカウントを有効化するためのメールを送信しました。メールをご確認ください。"
      expect(current_path).to eq root_path
    end

    it "有効化せずにログインするとホーム画面にリダイレクトする" do
      visit login_path
      fill_in "Email", with: email
      fill_in "Password", with: password
      click_button "ログイン"
      expect(current_path).to eq root_path
      expect(page).to_not have_selector "a", text: "ログアウト"
    end
  end
end
