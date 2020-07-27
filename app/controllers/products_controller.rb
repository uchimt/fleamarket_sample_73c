class ProductsController < ApplicationController
  before_action :set_category, only: [:new, :edit, :create, :update, :destroy]
  before_action :move_to_root, except: :show
  before_action :set_product, only: [:edit, :update, :show, :destroy]
  before_action :not_productuser, only: [:edit, :update]
  before_action :request_path, only: [:new, :edit, :create, :update]

  def index
    @products = Product.includes(:images).order('created_at DESC')
    @parents = Category.all.order("id ASC").limit(13) #１層目が13個なのでlimit(2)
  end

  
  def new
    @product = Product.new
    @product.images.build
    @brands = Brand.all
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

  # 孫カテゴリーが選択された後に動くアクション
  def get_size
    selected_grandchild = Category.find("#{params[:grandchild_id]}") #孫カテゴリーを取得
    if related_size_parent = selected_grandchild.sizes[0] #孫カテゴリーと紐付くサイズ（親）があれば取得
      @sizes = related_size_parent.children #紐付いたサイズ（親）の子供の配列を取得
    else
      selected_child = Category.find("#{params[:grandchild_id]}").parent #孫カテゴリーの親を取得
      if related_size_parent = selected_child.sizes[0] #孫カテゴリーの親と紐付くサイズ（親）があれば取得
        @sizes = related_size_parent.children #紐づいたサイズ（親）の子供の配列を取得
      end
    end
  end

  def create
    @brands = Brand.all
    @category_parent_array = Category.where(ancestry: nil)
    @sizes = Size.where(ancestry: nil)
    @product = Product.new(product_params)
    if @product.save
      redirect_to new_product_create_products_path
    else
      render :new and return
    end
  end

  def new_product_create
  end

  def edit
    @category_parent_array = Category.where(ancestry: nil)
    @category_children = @product.category.parent.children
    @category_grandchildren = @product.category.parent.children
  end

  def update
    @category_parent_array = Category.where(ancestry: nil)
    if @product.update(product_params)
      redirect_to product_path
    else
      render :edit
    end
  end

  def show
    @images = @product.images
  end

  def destroy
    @category_parent_array = Category.where(ancestry: nil)
    
    @product.destroy
    redirect_to products_path
  end

  private 

  def product_params
    params.require(:product)
                   .permit(:title, 
                           :description, 
                           :category_id,
                           :size_id,
                           :condition, 
                           :brand_id,
                           :postage, 
                           :prefecture_id, 
                           :shipping_day_id, 
                           :price, 
                           images_attributes: [:src, :_destroy, :id])
                           .merge(user_id: current_user.id)
  end

  #データベースから、親カテゴリーのみ抽出し、配列化
  def set_category  
    @category_parent_array = Category.where(ancestry: nil)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  # ログアウト状態でも商品詳細ページを見ることができるようにした
  def move_to_root
    redirect_to root_path unless user_signed_in?
  end

  # 投稿者だけが編集ページに遷移できるようにする
  def not_productuser
    if current_user.id != @product.user_id
      redirect_to root_path
    end
  end
  
  def request_path
    @path = controller_path + '#' + action_name
    def @path.is(*str)
        str.map{|s| self.include?(s)}.include?(true)
    end
  end

end
