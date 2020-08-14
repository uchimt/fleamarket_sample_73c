$(function(){
  function buildComment(comment){
    var html = `<div class="commentList__comment">
                <div class="commentList__content">
                  <div class="commentList__content--comment">
                  ${comment.comment}
                  </div>
                  <div class="commentList__content--delete">
                    <a data-confirm="本当に削除しますか？" rel="nofollow" data-method="delete" href="/products/:product_id/comments/2">
                      <i class="fa fa-trash"></i>
                      削除する
                    </a>
                    <div class="commentList__content--time">
                    ${comment.date}
                    </div>
                  </div>
                </div>
                <div class="commentList__userName">
                  ${comment.user_name}
                  <div class="commentList__userName--master">
                  出品者
                  </div>
                </div>
              </div>`

    return html;
  }

  $('#newComment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(comment){
      var html = buildComment(comment);
      $('.commentList').append(html);
      $('#comment_comment').val('');
      $('.commentBox__btn').prop('disabled',false);
    })
    .fail(function(){
      alert('エラー');
    })
  })
});