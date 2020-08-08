class ProductsController < ApplicationController
  require "payjp"
  before_action :set_category, only: [:new, :edit, :create, :update, :destroy]
  before_action :move_to_root, except: :show
  before_action :set_product, only: [:edit, :update, :show, :destroy, :buy, :purchase]

  def index
    @products = Product.includes(:images).order('created_at DESC')
    @parents = Category.all.order("id ASC").limit(13) #１層目が13個なのでlimit(13)
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
      redirect_to new_product_create_product_path(@product.id)
    else
      render action: :new, locals: { product: @product }
    end
  end

  def new_product_create
    @user = User.find(current_user.id)
  end

  def edit
    @category_id = @product.category_id
    @category_parent_array = Category.where(ancestry: nil)
    @category_children = @product.category.parent.parent.children
    @category_grandchildren = @product.category.parent.children
    # サイズを取得するメソッド
    selected_grandchild =Category.find(@category_id)
    if related_size_parent = selected_grandchild.sizes[0]
      @sizes = related_size_parent.children
    else
      selected_child =Category.find(@category_id).parent
      if related_size_parent = selected_child.sizes[0]
        @sizes = related_size_parent.children
      end
    end

  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product.id)
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

  def buy
    @creditcard = CreditCard.find_by(user_id: current_user.id)
    @address = Destination.find_by(user_id: current_user.id)
  
    Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    customer = Payjp::Customer.retrieve(@creditcard.customer_id)
    @creditcard_information = customer.cards.retrieve(@creditcard.card_id)
    @card_brand = @creditcard_information.brand

    case @card_brand
      when "Visa"
        @card_image = "visa_card.svg"
      when "JCB"
        @card_image = "jcb.svg"
      when "MasterCard"
        @card_image = "master_card.svg"
      when "American Express"
        @card_image = "american_express.svg"
      when "Diners Club"
        @card_image = "diners.svg"
      when "Discover"
        @card_image = "discover.svg" 
      end
    end

    def purchase
      @creditcard = CreditCard.find_by(user_id: current_user.id)
     
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]

      #payjp経由で支払いを実行
      charge = Payjp::Charge.create(
        amount: @product.price,
        customer: Payjp::Customer.retrieve(@creditcard.customer_id),
        currency: 'jpy'
      )
      @product_buyer= Product.find(params[:id])
      @product_buyer.update(status:'sold',buyer_id: current_user.id)
      redirect_to purchased_product_path
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
end
