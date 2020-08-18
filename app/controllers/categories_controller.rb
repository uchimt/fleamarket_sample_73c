class CategoriesController < ApplicationController
    
  def index
    @parents = Category.where(ancestry: nil).order('id ASC').limit(13) #１層目が１３個なのでlimit(13)
  end

  def show
    @category = Category.find(params[:id])
    @category_products = Product.includes(:images).where(category_id: params[:id]).order('created_at DESC')
  end

end
