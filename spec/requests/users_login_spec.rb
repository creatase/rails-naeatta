require "rails_helper"

RSpec.describe "Users Signup", type: :request do
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
end
