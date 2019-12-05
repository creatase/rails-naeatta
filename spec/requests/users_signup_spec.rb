require "rails_helper"

RSpec.describe "Users Signup", type: :request do
  example '無効な情報で登録に失敗すると登録画面を表示する' do
    get signup_path
    expect{
      post users_path, params: {
        user: {
          name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"
          }
        }
      }.to change{ User.count }.by(0)
    expect(response).to render_template(:new)
  end

  example '有効な情報で登録に成功すると詳細画面を表示する' do
    get signup_path
    expect{
      post users_path, params: {
        user: {
          name: "Example User",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    }.to change{User.count}.by(1)
    expect(response).to redirect_to(user_path(User.last))
    follow_redirect!

    expect(response).to render_template(:show)

  end
end