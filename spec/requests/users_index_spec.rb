require "rails_helper"

RSpec.describe "Users index", type: :request do
  before do
    FactoryBot.create(:user, name: "Michael Example", email: "michael@example.com")
    FactoryBot.create(:user, name: "Sterling Archer", email: "duchess@example.gov")
    FactoryBot.create(:user, name: "Lana Kane", email: "hands@example.gov")
    FactoryBot.create(:user, name: "Malory Archer", email: "boss@example.gov")

    30.times do |i|
      FactoryBot.create(:user, name: "User #{i}", email: "user-#{i}@example.com")
    end
  end

  example "ユーザー一覧ページにページネーションがある" do
    user = User.first
    log_in_as(user)
    get users_path
    expect(response).to render_template(:index)
  end
end
