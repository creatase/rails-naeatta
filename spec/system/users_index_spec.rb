require "rails_helper"

RSpec.describe "Users Index", type: :system do
  before do
    @admin = FactoryBot.create(:user, name: "Michael Example", email: "michael@example.com")
    @non_admin = FactoryBot.create(:user, name: "Sterling Archer", email: "duchess@example.gov")
    FactoryBot.create(:user, name: "Lana Kane", email: "hands@example.gov")
    FactoryBot.create(:user, name: "Malory Archer", email: "boss@example.gov")

    30.times do |i|
      FactoryBot.create(:user, name: "User #{i}", email: "user-#{i}@example.com")
    end
    @admin.update_attribute(:admin, true)
  end

  describe "管理者ログイン" do
    before do
      visit login_path
      fill_in "Email", with: @admin.email
      fill_in "Password", with: "password"
      click_button "ログイン"
      visit users_path
    end

    example "ユーザー一覧ページにページネーションがある" do
      expect(page).to have_css ".pagination"
    end

    example "各ユーザー詳細ページへのリンクと管理者意外のユーザーの削除リンクがある" do
      User.paginate(page: 1).each do |user|
        expect(page).to have_selector "a", text: user.name
        unless user == @admin
          expect(page).to have_link "削除", href: user_path(user)
        end
      end
    end

    example "管理者意外のユーザーを削除できる" do
      expect {
        first(".users li").click_link "削除"
      }.to change { User.count }.by(-1)
    end
  end

  describe "管理者意外でログイン" do
    example "削除リンクが表示されない" do
      visit login_path
      fill_in "Email", with: @non_admin.email
      fill_in "Password", with: "password"
      click_button "ログイン"

      visit users_path
      expect(page).to_not have_selector "a", text: "削除"
    end
  end
end
