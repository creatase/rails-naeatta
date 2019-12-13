require "rails_helper"

RSpec.describe "Users Delete", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user, name: "Sterling Archer", email: "duchess@example.gov") }

  before do
    user.update_attribute(:admin, true)
    activate(user)
    activate(other_user)
  end

  it "ログアウトではログイン画面にリダイレクトされる" do
    expect {
      delete user_path(user)
    }.to change { User.count }.by(0)
    expect(response).to redirect_to(login_path)
  end

  it "管理者意外のログインではホーム画面にリダイレクトされる" do
    log_in_as(other_user)
    expect {
      delete user_path(user)
    }.to change { User.count }.by(0)
    expect(response).to redirect_to(root_path)
  end

  it "管理者ログインではユーザーを削除できる" do
    log_in_as(user)
    expect {
      delete user_path(other_user)
    }.to change { User.count }.by(-1)
    expect(response).to redirect_to(users_url)
  end
end
