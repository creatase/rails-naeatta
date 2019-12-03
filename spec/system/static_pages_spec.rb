require "rails_helper"

RSpec.describe "Static Pages", :type => :system do
  let(:base_title) { 'naeatta' }

  describe 'root' do
    it 'Home画面の表示' do
      visit '/'
      expect(page).to have_title "Home | #{ base_title }"
    end
  end
  describe 'Home' do
    it '画面の表示' do
      visit '/static_pages/home'
      expect(page).to have_title "Home | #{ base_title }"
    end
  end
  describe 'About' do
    it '画面の表示' do
      visit '/static_pages/about'
      expect(page).to have_title "About | #{ base_title }"
    end
  end
  describe 'Help' do
    it '画面の表示' do
      visit '/static_pages/help'
      expect(page).to have_title "Help | #{ base_title }"
    end
  end
  describe 'Contact' do
    it '画面の表示' do
      visit '/static_pages/contact'
      expect(page).to have_title "Contact | #{ base_title }"
    end
  end
end