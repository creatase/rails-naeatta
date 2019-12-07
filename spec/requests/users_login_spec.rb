require "rails_helper"

RSpec.describe "Users Login", type: :request do
  let!(:user) { FactoryBot.create(:user) }

  example '無効な情報でログインに失敗するとログイン画面を表示する' do
    get login_path
    expect(response).to render_template(:new)
    log_in_as(user, email: "user@invalid", password: "foo")
    expect(response).to render_template(:new)
  end

  describe '有効な情報でログイン' do
    before do
      get login_path
      expect(response).to render_template(:new)
      log_in_as(user)
    end

    example '成功するとユーザー詳細画面を表示する' do
      expect(response).to redirect_to(user_path(user))
      follow_redirect!
      expect(response).to render_template(:show)
    end

    example 'ログアウトするとホーム画面を表示する' do
      get user_path(user)
      expect(response).to render_template(:show)

      delete login_path
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response).to render_template(:home)

      delete login_path
      follow_redirect!
      expect(response).to render_template(:home)
    end
  end

end
