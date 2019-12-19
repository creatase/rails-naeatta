require "rails_helper"

RSpec.describe "Seedlingsposts", type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, name: "other", email: "other@mail.com") }
  let(:post) { FactoryBot.create(:seedlingspost, user: user) }
  let(:other_users_post) { FactoryBot.create(:seedlingspost, user: other_user) }

  before do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "ログイン"
  end

  describe "無効な情報を送信" do
    example "苗情報が表示される" do
      expect {
        visit root_path
        fill_in "品目名", with: ""
        fill_in "規格", with: ""
        fill_in "穂木", with: ""
        fill_in "台木", with: ""
        fill_in "本数", with: ""
        fill_in "生産地", with: ""
        fill_in "発注単位", with: ""
        click_button "登録"
      }.to change { Seedlingspost.count }.by(0)

      expect(page).to have_css "#error_explanation"
    end
  end

  describe "有効な情報を送信" do
    example "苗情報が表示される" do
      visit root_path
      expect(page).to have_selector "#seedlingspost_picture"
      expect {
        fill_in "品目名", with: "スイカ"
        fill_in "規格", with: "９cmポット"
        fill_in "穂木", with: "夏美"
        fill_in "台木", with: "なし"
        fill_in "本数", with: "100"
        fill_in "生産地", with: "東京"
        fill_in "発注単位", with: "10"
        attach_file "苗の状態", "#{Rails.root}/spec/factories/seedlings_image.jpg"
        click_button "登録"
      }.to change { Seedlingspost.count }.by(1)

      expect(current_path).to eq root_path
      expect(page).to have_content "スイカ"
    end
  end

  example "ログイン中のユーザーの投稿には削除リンクが表示される" do
    post
    visit root_path
    expect(page).to have_content post.item
    expect(page).to have_link "削除", href: seedlingspost_path(post)
  end

  example "ログイン中のユーザー以外のユーザーの投稿には削除リンクを表示しない" do
    other_users_post
    visit user_path(other_user)
    expect(page).to have_content other_users_post.item
    expect(page).to_not have_link "削除"
  end

  example "投稿するとユーザー名下の投稿数が１つ増える" do
    visit root_path
    expect(page).to have_content "0 seedlingsposts"
    post
    visit root_path
    expect(page).to have_content "1 seedlingspost"
  end
end
