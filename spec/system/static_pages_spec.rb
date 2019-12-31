require "rails_helper"

RSpec.describe "Static Pages", type: :system do
  let(:base_title) { "naeatta" }
  let(:user) { FactoryBot.create(:user) }

  describe "ナビゲーション" do
    it "各ページへのリンクがある" do
      visit "/"
      expect(page).to have_link nil, href: root_path, count: 2
      expect(page).to have_link "ヘルプ", href: help_path
      expect(page).to have_link "使い方", href: about_path
      expect(page).to have_link "問合せ", href: contact_path
    end
  end

  describe "Home" do
    describe "ログアウト時" do
      before do
        visit "/"
      end

      context "画面を表示したとき" do
        it "titleは naeatta のみ" do
          expect(page).to have_title base_title
          expect(page).to_not have_title "ホーム |"
        end
        it "新規登録のリンクがある" do
          expect(page).to have_link "新規登録", href: signup_path
        end
      end
    end

    describe "ログイン時" do
      before do
        visit login_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"
        visit "/"
      end

      context "画面を表示した時" do
        it "ログインユーザー名を表示する" do
          expect(page).to have_content user.name
          expect(page).to have_link "マイページ", href: user_path(user)
          expect(page).to have_link "苗情報を投稿する", href: post_path
        end
      end
    end
  end

  describe "About" do
    it "画面の表示" do
      visit "/about"
      expect(page).to have_title "使い方 | #{base_title}"
    end
  end

  describe "Help" do
    it "画面の表示" do
      visit "/help"
      expect(page).to have_title "ヘルプ | #{base_title}"
    end
  end

  describe "Contact" do
    it "画面の表示" do
      visit "/contact"
      expect(page).to have_title "問合せ | #{base_title}"
    end
  end
end
