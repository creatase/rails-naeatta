require "rails_helper"

RSpec.describe "Users Index", type: :system do
  before do
    FactoryBot.create(:user, name: "Michael Example", email: "michael@example.com")
    FactoryBot.create(:user, name: "Sterling Archer", email: "duchess@example.gov")
    FactoryBot.create(:user, name: "Lana Kane", email: "hands@example.gov")
    FactoryBot.create(:user, name: "Malory Archer", email: "boss@example.gov")

    30.times do |i|
      FactoryBot.create(:user, name: "User #{i}", email: "user-#{i}@example.com")
    end
  end

  example "ユーザー一覧ページにページネーションがある" do
    login_user = User.first
    visit login_path
    fill_in "Email", with: login_user.email
    fill_in "Password", with: "password"
    click_button "ログイン"

    visit users_path
    expect(page).to have_css ".pagination"
    User.paginate(page: 1).each do |user|
      expect(page).to have_selector "a", text: user.name
    end
  end
end
