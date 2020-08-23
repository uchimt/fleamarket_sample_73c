require 'rails_helper'

describe User do
  describe '新規ユーザー登録' do

    it "すべてを正しく入力した場合は登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "nikcnameがない場合は登録できないこと" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "emailに@がない場合は登録できないこと" do
      user = build(:user, email: "kaneko.jp")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "emailが重複した場合は登録できないこと" do
      #はじめにユーザーを登録
      user = create(:user)
      #先に登録したユーザーと同じemailの値を持つユーザーのインスタンスを作成
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "passwordが７文字未満の場合は登録できないこと" do
      user = build(:user, password: 234156)
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it "password_confirmationがない場合は登録できないこと" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password_confirmation])
    end

  end
end