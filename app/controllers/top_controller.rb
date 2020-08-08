class TopController < ApplicationController
  def index
    @products = Product.includes(:images).where(status: 0).order('created_at DESC')
  end
end
