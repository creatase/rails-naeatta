require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do

  describe 'ログイン状態がcookieのみに保持されている場合' do

    before do
      @user = FactoryBot.build(:user)
      remember(@user)
    end

    it 'current_userメソッドがログインユーザーを返す' do
      expect(current_user).to eq @user
      expect(is_logged_in?).to be_falsey
    end

    it '記憶ダイジェストが無効な場合current_userはnilを返す' do
      @user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to be_nil
    end
  end


end
