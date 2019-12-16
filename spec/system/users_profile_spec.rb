require "rails_helper"

RSpec.describe "Users Profile", type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe "プロフィール画面の表示" do
    example "苗情報が表示されている" do
      50.times { FactoryBot.create(:seedlingspost, user: user) }
      visit user_path(user)
      expect(page).to have_title user.name
      expect(page).to have_css "h1", text: user.name
      expect(page.body).to have_content user.seedlingsposts.count.to_s
      expect(page).to have_selector "div .pagination"
      user.seedlingsposts.paginate(page: 1).each do |seedlingspost|
        expect(page).to have_content seedlingspost.item
      end
    end
  end
end
