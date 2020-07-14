class ProductsController < ApplicationController

  require 'payjp'

  def pay
    @product = Product.find(params[:id])
    Payjp.api_key = "PAYJP_ACCESS_KEY"
    Payjp::Charge.create(
      amount: @product.price,
      card: params['payjp-token'], # フォームを送信すると生成されるトークン
      currency: 'jpy'
    )
  end
  private

  def product_params
    params.require(:product).permit(
      :title,
      :price,
      
    ).merge(user_id: current_user.id)
  end
  def new
  end

  def show
  end
  
end
