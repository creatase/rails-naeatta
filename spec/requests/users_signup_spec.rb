require "rails_helper"

RSpec.describe "Users Signup", type: :request do
  before do
    ActionMailer::Base.deliveries.clear
  end

  example "無効な情報で登録に失敗すると登録画面を表示する" do
    get signup_path
    expect {
      post users_path, params: {
        user: {
          name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar",
        },
      }
    }.to change { User.count }.by(0)
    expect(response).to render_template(:new)
  end

  example "有効な情報で登録に成功すると詳細画面を表示する" do
    get signup_path
    expect {
      post users_path, params: {
        user: {
          name: "Example User",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password",
        },
      }
    }.to change { User.count }.by(1)

    expect(ActionMailer::Base.deliveries.size).to eq 1
    user = assigns(:user)
    expect(user.activated?).to be_falsey

    # 有効化していない状態でログインしてみる
    log_in_as(user)
    expect(is_logged_in?).to be_falsey

    # 有効化トークンが不正な場合
    get edit_account_activation_url("invalid token", email: user.email)
    expect(is_logged_in?).to be_falsey

    # トークンは正しいがメールアドレスが無効な場合
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    expect(is_logged_in?).to be_falsey

    # 有効化トークンが正しい場合
    get edit_account_activation_path(user.activation_token, email: user.email)
    expect(user.reload.activated?).to be_truthy

    expect(response).to redirect_to(user_path(user))
    follow_redirect!
    expect(is_logged_in?).to be_truthy
  end
end
