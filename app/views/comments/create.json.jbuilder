json.user_name  @comment.user.nickname
json.id         @comment.id
json.comment    @comment.comment
json.date       @comment.created_at.strftime("%Y年%m月%d日 %H時%M分")
