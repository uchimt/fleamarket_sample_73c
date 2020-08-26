require 'rails_helper'

describe ProductsController do
  describe 'POST #create' do
    let(:user) { create(:user)}
    let(:params) {{user_id: user.id, product:  attributes_for(:product) }}
    
    context "userがログインしている場合" do 
      before do
        login user
      end

      it "products/newに遷移すること" do
        get :new
        expect(response).to render_template :new
      end

      context '保存に成功した場合' do
        subject {
          post :create,
          params: params
        }

        it "出品した商品情報が登録されること" do
          expect{ subject }.to change(Product, :count).by(1)
        end

        it "商品出品後new_product_createに遷移すること" do
          subject
          expect(response).to redirect_to(new_product_create_product_path(:product))
        end
      end

      context '保存に失敗した場合' do
        let(:invalid_params) {{ user_id: user.id, product: attributes_for(:product, title: nil) }}
        
        subject {
          post :create,
          params: invalid_params
        }

        it 'productを保存しないこと' do
          expect { subject }.not_to change(Product, :count)
        end

        it 'product/newに遷移すること' do
          subject
          expect(response).to render_template :new
        end
      end
    end 

    context "userが未ログインの場合" do

      it "newアクションが呼び出されるとトップページに遷移すること" do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    context "userがログインしている場合" do 
    end

    context "userが未ログインの場合" do
    end
  end

end