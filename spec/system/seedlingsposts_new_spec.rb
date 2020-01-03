require "rails_helper"

RSpec.describe "Seedlingsposts new", type: :system do
  describe "ログアウト字" do
    example "アクセスするとログイン画面にリダイレクトする" do
      visit post_path
      expect(current_path).to eq login_path
      expect(page).to have_button "ログイン"
    end
  end

  let(:user) { FactoryBot.create(:user) }

  describe "ログイン時" do
    before do
      visit login_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
      visit post_path
    end

    example "投稿ページが表示される" do
      expect(current_path).to eq post_path
      expect(page).to have_content "苗情報投稿"
    end

    example "有効な情報を入力して投稿すると苗検索ページにリダイレクトする" do
      expect {
        fill_in "品目名", with: "スイカ"
        fill_in "規格", with: "９cmポット"
        fill_in "品種名", with: "夏のスイカ"
        fill_in "台木", with: "（なし）"
        fill_in "本数", with: "400"
        fill_in "生産地", with: "京都"
        fill_in "発注単位", with: "40"
        click_button "登録"
      }.to change{user.seedlingsposts.count}.by(1)
      expect(current_path).to eq seedlingsposts_path
      expect(page).to have_css ".alert-success"
    end

    example "無効な情報を入力して投稿すると苗投稿ページを再表示する" do
      expect {
        fill_in "品目名", with: ""
        fill_in "規格", with: ""
        fill_in "品種名", with: ""
        fill_in "台木", with: ""
        fill_in "本数", with: ""
        fill_in "生産地", with: ""
        fill_in "発注単位", with: ""
        click_button "登録"
      }.to change{user.seedlingsposts.count}.by(0)
      expect(current_path).to eq post_path
      expect(page).to have_css ".alert-danger"
    end

  end
end
