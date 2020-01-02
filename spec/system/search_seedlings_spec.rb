require "rails_helper"

RSpec.describe "Search Seedlings", type: :system do
  let(:user) {FactoryBot.create(:user)}
  let!(:watermelon) {FactoryBot.create(:seedlingspost, user: user, item: "スイカ", scion: "西瓜一号")}
  let!(:tomato) {FactoryBot.create(:seedlingspost, user: user, item: "トマト", scion: "夏の赤")}
  let!(:cucumber) {FactoryBot.create(:seedlingspost, user: user, item: "キュウリ", scion: "夏みどり")}

  before do
    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end

  describe "品目を指定したとき" do
    before do
      visit seedlingsposts_path
      fill_in "品目", with: "スイカ"
      click_button "検索"
    end

    example "指定した品目の投稿が表示される" do
      expect(page).to have_content "スイカ"
    end

    example "指定した品目以外の投稿を表示しない" do
      expect(page).to_not have_content "トマト"
      expect(page).to_not have_content "キュウリ"
    end
  end

  describe "完全な品種名で検索したとき" do
    before do
      visit seedlingsposts_path
      fill_in "品種", with: "西瓜一号"
      click_button "検索"
    end

    example "検索した品種名の投稿が表示される" do
      expect(page).to have_content "西瓜一号"
    end

    example "検索した品種名意外の投稿は表示しない" do
      expect(page).to_not have_content "夏の赤"
      expect(page).to_not have_content "夏みどり"
    end
  end

  describe "部分的な品種名で検索したとき" do
    before do
      visit seedlingsposts_path
      fill_in "品種", with: "夏"
      click_button "検索"
    end

    example "検索した文字列を品種名に含む投稿が表示される" do
      expect(page).to have_content "夏の赤"
      expect(page).to have_content "夏みどり"
    end

    example "検索した品種名意外の投稿は表示しない" do
      expect(page).to_not have_content "西瓜一号"
    end
  end
end
