class UsersController < ApplicationController
  before_action :set_search
  def show
    @user = User.find(current_user.id)
    @my_purchased_products = Product.includes(:images).where(buyer_id: current_user.id, status: 1).order('created_at DESC').page(params[:page]).per(5)
  end
  
  def on_display_products
    @my_on_display_products = Product.includes(:images).where(user_id: current_user.id, status: 0).order('created_at DESC').page(params[:page]).per(5)
  end

  def sold_products
    @my_sold_products = Product.includes(:images).where(user_id: current_user.id, status: 1).order('created_at DESC').page(params[:page]).per(5)
  end

  def purchased_products
    @my_purchased_products = Product.includes(:images).where(buyer_id: current_user.id, status: 1).order('created_at DESC').page(params[:page]).per(5)
  end

  def logout_link
  end

end
