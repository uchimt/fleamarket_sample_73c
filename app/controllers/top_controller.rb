class TopController < ApplicationController
  def index
    @products = Product.includes(:images).where(status: 0).order('created_at DESC')
    @user = User.find(current_user.id)
  end
end
