class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @sellerId = @comment.product.user_id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to product_path(@comment.product.id) }  # 商品詳細画面へ遷移
        format.json
      else
        format.html { render :show } 
        format.json { render :show } 
    end
    
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