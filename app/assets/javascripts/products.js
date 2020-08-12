$(function() { 
  //プレビューのthmlを定義
  function buildHTML(count) {
    var html = `<div class="preview_image_box" id="preview_image_box__${count}">
                  <div class="upper-box">
                    <img src="" alt="preview" width="120px" height="120px" class=""preview_image>
                  </div>
                  <div class="update_box">
                    <div class="js-remove" id="delete_btn_${count}">
                      <span>削除</span>
                    </div>
                  </div>
                </div>`;
    return html;
  }

  //投稿編集時
  //products/:i/editページへリンクした際のアクション
  if (window.location.href.match(/\/products\/\d+\/edit/)) {
    //投稿済み画像のプレビュー表示欄の要素を取得する
    var prevContent = $('.image_input_btn').prev();
    labelWidth = (640 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
    $('.image_input_btn').css('width', labelWidth);
    //プレビューの要素数を取得
    var count = $('.preview_image_box').length;
    //プレビューが５つあるときは、投稿ボックスを消しておく
    if (count == 5) {
      $('.image_input_btn').hide();
    }
  }
  //
  
  // image_input_btnのwidth操作
  function setLabel() {
    // プレビューボックスのwidthを取得し、maxから引くことでimage_input_btnのwidthを決定
    var prevContent = $('.image_input_btn').prev();
    labelWidth = (640 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
    $('.image_input_btn').css('width', labelWidth);
  }
  //

  // プレビューの追加
  $('#image-box').on('change', '.hidden-field', function() {
    setLabel();
    // hidden-fieldのidの数値のみ取得
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    // image_input_btnのidとforを更新
    $('.image_input_btn').attr({id: `image_input_btn--${id}`, for: `product_images_attributes_${id}_src`});
    // 選択したfileのオブジェクトを取得
    var file = this.files[0];
    var reader = new FileReader();
    //readAsDataURLで指定したFileオブジェクトを読み込む
    reader.readAsDataURL(file);
    //読み込み時に発火するイベント
    reader.onload = function() {
      var image = this.result;
      //プレビューがもともと無かった場合はhtmlを追加
      if ($(`#preview_image_box__${id}`).length == 0) {
        var count = $('.preview_image_box').length;
        var html = buildHTML(id);
        //ラベルの直前のプレビュー群にプレビューを追加
        var prevContent = $('.image_input_btn').prev();
        $(prevContent).append(html);
      }
      //イメージを追加
      $(`#preview_image_box__${id} img`).attr('src', `${image}`);
      var count = $('.preview_image_box').length;
      //プレビューが5こあったらラベルを隠す
      if (count == 5) {
        $('.image_input_btn').hide();
      }
      //プレビューを削除したフィールドにdestroy用のチェックボックスがあった場合、チェックを外す
      if ($(`#product_images_attributes_${id}__destroy`)) {
        $(`#product_images_attributes_${id}__destroy`).prop('checked', false);
      }
      //image_input_btnのwidth操作
      setLabel();
      //image_input_btnのidとforの値を変更
      
      if (count < 5) {
        //プレビューの数でラベルのオプションを更新する 
        $('.image_input_btn').attr({id: `image_input_btn--${count}`, for:`product_images_attributes_${count}_src`});
      }
    }
  });

  //画像の削除
  $('#image-box').on('click', '.js-remove', function() {
    var count = $('.preview_image_box').length;
    setLabel(count);
    //product_images_attributes_${id}_srcのidの数値のみ取得
    var id = $(this).attr('id').replace(/[^0-9]/g, '');
    // 取得したidの該当するプレビューを削除
    $(`#preview_image_box__${id}`).remove();
    // フォームの中身を削除
    $(`#product_images_attributes_${id}_src`).val("");
    $(`#product_images_attributes_${id}__destroy`).prop('checked',true);
    // 削除時のラベル操作
    var count = $('.preview_image_box').length;
    // 5個目が消されたらラベルを表示
    if (count == 4) {
      $('.image_input_btn').show();
    }
    //image_input_btnのwidth操作
    setLabel();
    if(id < 5) {
      // 削除された際に、空っぽになったfile_fieldをもう一度入力可能にする。
      $('.image_input_btn').attr({id: `image_input_btn--${id}`, for: `product_images_attributes_${id}_src`});
    }
  });
});