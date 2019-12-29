require "rails_helper"

RSpec.describe "Static Pages", type: :system do
  let(:base_title) { "naeatta" }

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
