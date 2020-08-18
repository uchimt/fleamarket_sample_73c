class CategoriesController < ApplicationController
  before_action :set_category, only: :show

  def index
    @parents = Category.where(ancestry: nil).order('id ASC').limit(13) #１層目が１３個なのでlimit(13)
  end

  def show
    @category_products =@category.set_products
    @category_products = @category_products.includes(:images).order('created_at DESC').page(params[:page]).per(25)
  end

  private
  def set_category
    @category = Category.find(params[:id])
    if @category.has_children?
      @category_links = @category.children
    else
      @category_links = @category.siblings
    end
  end
end
