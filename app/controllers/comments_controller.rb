class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to product_path                  # 商品詳細画面へ遷移
  end
end
