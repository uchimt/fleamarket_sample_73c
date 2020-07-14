class ProductsController < ApplicationController

  # before_action :set_category, only: [:new, :edit, :create, :update, :destroy]

  def index
    @products = Product.includes(:images).order('created_at DESC')
    # @parents = Category.all.order("id ASC").limit(2) #１層目が2個なのでlimit(2)
  end

  def new
    @product = Product.new
    @product.images.build
    @product.build_brand
    #データベースから、親カテゴリーのみ抽出し、配列化
    @category_parent_array = Category.where(ancestry: nil)
  end

  #親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find(params[:parent_name]).children
  end
  #子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  

  def create
    @category_parent_array = Category.where(ancestry: nil)
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    @category_parent_array = Category.where(ancestry: nil)
    @category_children = @product.category.parent.children
    @category_grandchildren = @product.category.parent.children
  end

  def update
    @category_parent_array = Category.where(ancestry: nil)
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @category_parent_array = Category.where(ancestry: nil)
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private 

  def product_params
    params.require(:product)
                   .permit(:title, 
                           :description, 
                           :category_id,
                           :condition, 
                           :postage, 
                           :prefecture_id, 
                           :shipping_day_id, 
                           :price, 
                           images_attributes: [:src, :_destroy, :id],
                           brand_attributes: [:brand_name, :_destroy, :id])
                           .merge(user_id: current_user.id)
  end

  #データベースから、親カテゴリーのみ抽出し、配列化
  def set_category  
    @category_parent_array = Category.where(ancestry: nil)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end