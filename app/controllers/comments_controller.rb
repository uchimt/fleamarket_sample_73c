class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html { redirect_to product_path(@comment.product.id) }  # 商品詳細画面へ遷移
      format.json
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to product_path(comment.product.id)  # 商品詳細画面へ遷移
    else
      redirect_to product_path(comment.product.id), alert: "削除が失敗しました"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end