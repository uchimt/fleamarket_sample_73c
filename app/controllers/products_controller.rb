class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @Product = Product.new
  end

  def create
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
