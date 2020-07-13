class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create, :get_category_children, :get_category_grandchildren]

  def index
    @products = Product.includes(:images).order('created_at DESC')
    @parents = Category.all.order("id ASC").limit(13)
  end

  def new
    #セレクトボックスの初期値設定
    @category_parent_array = ["選択してください"]
    #データベースから、親カテゴリーのみ抽出し、配列化
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    @product = Product.new
    @product.images.build
    @product.build_brand
  end

  #親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end
  #子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
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

  def set_product
    @product = Product.find(params[:id])
  end

end