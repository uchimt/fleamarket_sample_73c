class TopController < ApplicationController
  def index
    @products = Product.includes(:images).where(status: 0).order('created_at DESC')
    # @products = Product.includes(:images).order('created_at DESC')
    #   if product.status == 0
    #    show.images
    #   end
  end
end
