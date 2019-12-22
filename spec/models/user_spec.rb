require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user, name: "other", email: "other@mail.com") }

  describe "バリデーション" do
    describe "params nameが" do
      context "あるとき" do
        it "パスする" do
          expect(user.valid?).to be_truthy
        end
      end

      context "空文字のとき" do
        it "パスしない" do
          user.name = ""
          expect(user.valid?).to be_falsey
        end
      end

      context "スペースのみのとき" do
        it "パスしない" do
          user.name = "      "
          expect(user.valid?).to be_falsey
        end
      end

      context "51文字以上のとき" do
        it "パスしない" do
          user.name = "a" * 51
          expect(user.valid?).to be_falsey
        end
      end

      context "50文字以下のとき" do
        it "パスする" do
          user.name = "a" * 50
          expect(user.valid?).to be_truthy
        end
      end
    end

    describe "params emailが" do
      context "あるとき" do
        it "パスする" do
          expect(user.valid?).to be_truthy
        end
      end
      context "空文字のとき" do
        it "パスしない" do
          user.email = ""
          expect(user.valid?).to be_falsey
        end
      end
      context "スペースのみのとき" do
        it "パスしない" do
          user.email = "      "
          expect(user.valid?).to be_falsey
        end
      end
      context "256文字以上のとき" do
        it "パスしない" do
          user.email = "a" * (256 - "@example.com".length) + "@example.com"
          expect(user.valid?).to be_falsey
        end
      end
      context "255文字以下のとき" do
        it "パスする" do
          user.email = "a" * (255 - "@example.com".length) + "@example.com"
          expect(user.valid?).to be_truthy
        end
      end
      context "有効なアドレスのとき" do
        it "パスする" do
          user.email = "user@example.com"
          expect(user.valid?).to be_truthy
          user.email = "USER@foo.COM"
          expect(user.valid?).to be_truthy
          user.email = "A_US-ER@foo.bar.org"
          expect(user.valid?).to be_truthy
          user.email = "first.last@foo.jp"
          expect(user.valid?).to be_truthy
          user.email = "alice+bob@baz.cn"
          expect(user.valid?).to be_truthy
        end
      end
      context "無効なアドレスのとき" do
        it "パスしない" do
          user.email = "user@example,com"
          expect(user.valid?).to be_falsey
          user.email = "user_at_foo.org"
          expect(user.valid?).to be_falsey
          user.email = "user.name@example."
          expect(user.valid?).to be_falsey
          user.email = "foo@bar_baz.com"
          expect(user.valid?).to be_falsey
          user.email = "foo@bar+baz.com"
          expect(user.valid?).to be_falsey
          user.email = "foo@bar..com"
          expect(user.valid?).to be_falsey
        end
      end
      context "すでに使用されているとき" do
        it "パスしない" do
          duplicate_user = user.dup
          duplicate_user.email = user.email.upcase
          user.save!
          expect(duplicate_user.valid?).to be_falsey
        end
      end
    end

    describe "password password_confirmationが" do
      context "空文字のとき" do
        it "パスしない" do
          user.password = user.password_confirmation = " " * 6
          expect(user.valid?).to be_falsey
        end
      end
      context "5文字以下のとき" do
        it "パスしない" do
          user.password = user.password_confirmation = "a" * 5
          expect(user.valid?).to be_falsey
        end
      end
      context "6文字以上のとき" do
        it "パスする" do
          user.password = user.password_confirmation = "a" * 6
          expect(user.valid?).to be_truthy
        end
      end
    end
  end

  describe "登録内容" do
    it "emailは小文字に変換されていること" do
      user.email = "Foo@ExAMPle.CoM"
      user.save!
      expect(user.reload.email).to eq "foo@example.com"
    end
  end

  describe "認証" do
    it "cookies[:remember_token]がnilの状態ではauthenticated?はfalseを返す" do
      expect(user.authenticated?("")).to be_falsey
    end
  end

  it "フォロー、フォロー解除できる" do
    expect(user.following?(other_user)).to be_falsey
    user.follow(other_user)
    expect(user.following?(other_user)).to be_truthy
    expect(other_user.followers.include?(user)).to be_truthy
    user.unfollow(other_user)
    expect(user.following?(other_user)).to be_falsey
  end
end
