class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new, :create]

  def index
    @products = Product.includes(:images).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.images.new
    @product.build_brand
    # @category_parent_array = ["---"]
    # Category.where(ancestry: nil).each do |parent|
    #   @category_parent_array << parent.name
    # end
    # def get_category_children
    #   #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    #   @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
    # end
    # def get_category_grandchildren
    #   #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    #   @category_grandchildren = Category.find("#{params[:child_id]}").children
    # end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private 

  def product_params
    params.require(:product).permit(:title, :description, :condition, :postage, :prefecture_id, :shipping_day_id, :price, images_attributes: [:src, :_destroy, :id], brand_attributes: [:brand_name, :_destroy, :id])
  end

  # def brand_params
  #   params.require(:brand).permit(:brand_name)
  # end

  def set_product
    @product = Product.find(params[:id])
  end

end
