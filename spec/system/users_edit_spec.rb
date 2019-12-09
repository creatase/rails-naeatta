require "rails_helper"

RSpec.describe "Users Edit", type: :system do
  let(:user) { FactoryBot.create(:user) }

  example '有効な情報の場合、更新が成功する' do
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'ログイン'

    visit edit_user_path(user)
    fill_in 'Name', with: 'Foo Bar'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: ''
    fill_in 'Confirmation', with: ''
    click_button '更新'

    expect(current_path).to eq user_path(user)
    expect(page).to have_content 'Profile updated'

  end
end