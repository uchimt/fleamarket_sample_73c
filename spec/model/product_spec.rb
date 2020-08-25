require 'rails_helper'

describe Product do
  describe 'POST #create' do
  let!(:user) { create(:user) }
  
    before do
      @user = FactoryBot.create(:user)
    end

    it "images,title,description,category_id,condition,postage,prefecture_id,shipping_idとpriceがあれば登録できること" do
      product = FactoryBot.build(:product)
      product.valid?
      expect(product).to be_valid
    end

  end
end