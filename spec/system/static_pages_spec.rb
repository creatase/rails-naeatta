require "rails_helper"

RSpec.describe "Static Pages", type: :system do
  let(:base_title) { 'naeatta' }

  describe 'ナビゲーション' do
    before do
      visit '/'
    end
    it '各ページへのリンクがある' do
      expect(page).to have_link nil, href: root_path, count: 2
      expect(page).to have_link 'Help', href: help_path
      expect(page).to have_link 'About', href: about_path
      expect(page).to have_link 'Contact', href: contact_path
    end
  end

  describe 'root' do
    it 'Home画面の表示' do
      visit '/'
      expect(page).to have_title base_title
      expect(page).to_not have_title "Home |"
      end
  end
  describe 'About' do
    it '画面の表示' do
      visit '/about'
      expect(page).to have_title "About | #{ base_title }"
    end
  end
  describe 'Help' do
    it '画面の表示' do
      visit '/help'
      expect(page).to have_title "Help | #{ base_title }"
    end
  end
  describe 'Contact' do
    it '画面の表示' do
      visit '/contact'
      expect(page).to have_title "Contact | #{ base_title }"
    end
  end
end