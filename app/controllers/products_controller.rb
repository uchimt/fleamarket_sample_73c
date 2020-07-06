class ProductsController < ApplicationController
  def new
  end

  def show
    @product = Product.find(params[:id])
  end

end
