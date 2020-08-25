require 'rails_helper'

describe Destination do
  describe '住所登録' do
    
    it "すべてを正しく入力した場合は登録できること" do
      destination = build(:destination)
      expect(destination).to be_valid
    end

    it "destination_family_nameがない場合は登録できないこと" do
      destination = build(:destination, destination_family_name: nil)
      destination.valid?
      expect(destination.errors[:destination_family_name]).to include("を入力してください")
    end

    it "destination_family_name_kanaがない場合は登録できないこと" do
      destination = build(:destination, destination_family_name_kana: nil)
      destination.valid?
      expect(destination.errors[:destination_family_name_kana]).to include("を入力してください")
    end

    it "destination_first_nameがない場合は登録できないこと" do
      destination = build(:destination, destination_first_name: nil)
      destination.valid?
      expect(destination.errors[:destination_first_name]).to include("を入力してください")
    end

    it "destination_first_name_kanaがない場合は登録できないこと" do
      destination = build(:destination, destination_first_name_kana: nil)
      destination.valid?
      expect(destination.errors[:destination_first_name_kana]).to include("を入力してください")
    end

    it "postal_codeがない場合は登録できないこと" do
      destination = build(:destination, postal_code: nil)
      destination.valid?
      expect(destination.errors[:postal_code]).to include("を入力してください")
    end

    it "postal_codeが7文字未満の場合は登録できないこと" do
      destination = build(:destination, postal_code: 000000)
      destination.valid?
      expect(destination.errors[:postal_code])
    end

    it "postal_codeが8文字以上の場合は登録できないこと" do
      destination = build(:destination, postal_code: 00000000)
      destination.valid?
      expect(destination.errors[:postal_code])
    end

    it "prefecture_idがない場合は登録できないこと" do
      destination = build(:destination, prefecture_id: nil)
      destination.valid?
      expect(destination.errors[:prefecture_id]).to include("を入力してください")
    end

    it "cityがない場合は登録できないこと" do
      destination = build(:destination, city: nil)
      destination.valid?
      expect(destination.errors[:city]).to include("を入力してください")
    end

    it "addressがない場合は登録できないこと" do
      destination = build(:destination, address: nil)
      destination.valid?
      expect(destination.errors[:address]).to include("を入力してください")
    end

    it "buildingが未入力の場合でも登録できること" do
      destination = build(:destination, building: nil)
      expect(destination).to be_valid
    end

    it "phone_numberが未入力の場合でも登録できること" do
      destination = build(:destination, phone_number: nil)
      expect(destination).to be_valid
    end

  end
end