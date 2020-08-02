class UsersController < ApplicationController
  def show
    @name = current_user.nickname
    @my_products_on_display = Product.where(user_id: '#{current_user.id}', status: 0)
    @my_products_sold = Product.where(user_id: '#{current_user.id}', status: 1)
    @purchased_products
  end
end
