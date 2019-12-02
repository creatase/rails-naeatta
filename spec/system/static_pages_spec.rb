require "rails_helper"

RSpec.describe "Static Pages", :type => :system do
  describe 'Home' do
    specify '画面の表示' do
      visit '/static_pages/home'
      expect(page).to have_css('h1', text: 'Sample App')
    end
  end
end