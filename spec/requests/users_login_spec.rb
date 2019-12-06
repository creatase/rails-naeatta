require "rails_helper"

RSpec.describe "Users Login", type: :request do

  before do
    post users_path, params: {
      user: {
        name: "Example User",
        email: "user@example.com",
        password: "password",
        password_confirmation: "password"
      }
    }
  end

  example '無効な情報でログインに失敗するとログイン画面を表示する' do
    get login_path
    expect(response).to render_template(:new)
    post login_path, params: {
      session: {
        email: "user@invalid",
        password: "foo"
      }
    }
    expect(response).to render_template(:new)
  end

  describe '有効な情報でログイン' do
    before do
      get login_path
      expect(response).to render_template(:new)
      post login_path, params: {
        session: {
          email: "user@example.com",
          password: "password"
        }
      }
    end

    example '成功するとユーザー詳細画面を表示する' do
      expect(response).to redirect_to(user_path(User.last))
      follow_redirect!
      expect(response).to render_template(:show)
    end

    example 'ログアウトするとホーム画面を表示する' do
      get user_path(User.last)
      expect(response).to render_template(:show)

      delete login_path
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response).to render_template(:home)
    end
  end

end
