class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to product_path                  # 商品詳細画面へ遷移
  end

  private
  def comment_params
    params.require(:comment).permit(:comment).merage(user_id: current_user.id)
  end
end