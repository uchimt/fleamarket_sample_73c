class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @Product = Product.new
  end

  def create
    Product.create(product_params)
  end

  private
  def product_params
    params.permit(:name, :image, :text)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end
  
end
