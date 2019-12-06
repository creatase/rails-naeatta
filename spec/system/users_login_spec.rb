require "rails_helper"

RSpec.describe "Users Login", type: :system do

  describe '無効な情報でログインボタンを押下' do

    before do
      visit login_path
      fill_in 'Email', with: 'user@invalid'
      fill_in 'Password', with: 'foo'
      click_button 'ログイン'
    end

    it '再度ログイン画面を表示する' do
      expect(page).to have_title 'ログイン | naeatta'
    end

    it '表示されるフラッシュは別画面へ遷移すると消える' do
      expect(page).to have_css '.alert-danger'

      visit root_path
      expect(page).to_not have_css '.alert-danger'
    end

  end

  describe '有効な情報でログインボタンを押下' do

    it 'ユーザー詳細ページを表示する' do
      user = FactoryBot.create(:user)
      visit login_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'ログイン'

      expect(current_path).to eq user_path(user)
      expect(page).to_not have_selector 'a', text: 'ログイン'
      expect(page).to have_selector 'a', text: 'ログアウト'
      expect(page).to have_selector 'a', text: 'Profile'

    end

  end

end