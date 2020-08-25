require 'rails_helper'

describe Product do
  describe 'POST #create' do
    let!(:user) { create(:user) }

    before do
      @user = FactoryBot.create(:user)
    end

    it "images,title,description,category_id,condition,postage,prefecture_id,shipping_id と priceがある場合は登録できること" do
      product = build(:product)
      product.valid?
      expect(product).to be_valid
    end

    it "titleがない場合は登録できないこと" do
      product = build(:product, title: nil)
      product.valid?
      expect(product.errors[:title]).to include("を入力してください")
    end

    it "descriptionがない場合は登録できないこと" do
      product = build(:product, description: nil)
      product.valid?
      expect(product.errors[:description]).to include("を入力してください")
    end

    it "category_idがない場合は登録できないこと" do
        product = build(:product, category_id: nil)
        product.valid?
        expect(product.errors[:category_id]).to include("を入力してください")
    end

    it "conditionがない場合は登録できないこと" do
      product = build(:product, condition: nil)
      product.valid?
      expect(product.errors[:condition]).to include("を入力してください")
    end

    it "postageがない場合は登録できないこと" do
      product = build(:product, postage: nil)
      product.valid?
      expect(product.errors[:postage]).to include("を入力してください")
    end

    it "prefecture_idがない場合は登録できないこと" do
      product = build(:product, prefecture_id: nil)
      product.valid?
      expect(product.errors[:prefecture_id]).to include("を入力してください")
    end

    it "shipping_day_idがない場合は登録できないこと" do
      product = build(:product, shipping_day_id: nil)
      product.valid?
      expect(product.errors[:shipping_day_id]).to include("を入力してください")
    end

    it "conditionがない場合は登録できないこと" do
      product = build(:product, condition: nil)
      product.valid?
      expect(product.errors[:condition]).to include("を入力してください")
    end

    it "priceがない場合は登録できないこと" do
      product = build(:product, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("を入力してください")
    end

  end
end