require "rails_helper"

RSpec.describe "Users Edit", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:name) { 'Foo Bar' }
  let(:email) { 'foo@bar.com' }

  describe 'ログイン時' do

    before do
      log_in_as(user)
      get edit_user_path(user)
    end

    example '有効な情報の場合、更新に成功する' do
      expect(response).to render_template(:edit)
      patch user_path(user), params: {
        user: {
          name: name,
          email: email,
          password: '',
          password_confirmation: ''
        }
      }
      expect(response).to redirect_to(user_path(user))
      user.reload
      expect(user.name).to eq name
      expect(user.email).to eq email
    end

    example '無効な情報の場合、更新に失敗する' do
      expect(response).to render_template(:edit)
      patch user_path(user), params: {
        user: {
          name: '',
          email: 'foo@invalid',
          password: 'foo',
          password_confirmation: 'bar'
        }
      }
      expect(response).to render_template(:edit)
    end
  end

  describe 'ログアウト時' do

    before do
      delete logout_path
    end

    example 'ユーザー編集画面へのアクセスはログイン画面へリダイレクトする' do
      get edit_user_path(user)
      expect(response).to redirect_to(login_path)
      follow_redirect!
      expect(response).to render_template(:new)
    end

    example 'ユーザー情報更新のpostはログイン画面へリダイレクトする' do
      patch user_path(user), params: {
        user: {
          name: name,
          email: email,
          password: '',
          password_confirmation: ''
        }
      }
      expect(response).to redirect_to(login_path)
      follow_redirect!
      expect(response).to render_template(:new)
    end
  end
end