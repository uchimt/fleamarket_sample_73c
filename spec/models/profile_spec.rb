require 'rails_helper'

describe Profile do
  describe 'プロフィール登録' do
    
    it "すべてを正しく入力した場合には登録できること" do
      profile = build(:profile)
      expect(profile).to be_valid
    end

    it "family_nameがない場合には登録できないこと" do
      profile = build(:profile, family_name: nil)
      profile.valid?
      expect(profile.errors[:family_name]).to include("を入力してください")
    end

    it "family_name_kanaがない場合には登録できないこと" do
      profile = build(:profile, family_name_kana: nil)
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("を入力してください")
    end

    it "first_nameがない場合には登録できないこと" do
      profile = build(:profile, first_name: nil)
      profile.valid?
      expect(profile.errors[:first_name]).to include("を入力してください")
    end

    it "first_name_kanaがない場合には登録できないこと" do
      profile = build(:profile, first_name_kana: nil)
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("を入力してください")
    end

    it "birth_yearがない場合には登録できないこと" do
      profile = build(:profile, birth_year: nil)
      profile.valid?
      expect(profile.errors[:birth_year]).to include("を入力してください")
    end

    it "birth_monthがない場合には登録できないこと" do
      profile = build(:profile, birth_month: nil)
      profile.valid?
      expect(profile.errors[:birth_month]).to include("を入力してください")
    end

    it "birth_dayがない場合には登録できないこと" do
      profile = build(:profile, birth_day: nil)
      profile.valid?
      expect(profile.errors[:birth_day]).to include("を入力してください")
    end

  end
end