require "rails_helper"

RSpec.describe "Users Edit", type: :request do
  let(:user) { FactoryBot.create(:user) }

  example '有効な情報の場合、更新に成功する' do
    get edit_user_path(user)
    expect(response).to render_template(:edit)
    name = 'Foo Bar'
    email = 'foo@bar.com'
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
    get edit_user_path(user)
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