$(document).on('turbolinks:load', ()=> {
    // 画像用のinputを生成する関数
    const buildFileField = (num)=> {
      const html = `<div data-index="${num}" class="js-file_group">
                      <input class="js-file" type="file" name="product[images_attributes][${num}][src]" id="product_images_attributes_${num}_src"><br>
                    </div>`;
      return html;
    }
    // プレビュー用のimgボックスを生成する関数
    const buildImg = (index, url)=> {
      const html = `<div data-index="${index}" class="preview_image_group">
                      <img data-index="${index}" src="${url}" width="120px" height="120px" class=""preview_image>
                      <div class="update_box">
                        <div class="js-remove" id="delete_btn_${index}">
                          <span>削除</span>
                        </div>
                      </div>
                    </div>`;
      return html;
    }

    // image_input_btnのwidth操作
    function setLabel() {
      // プレビューボックスのwidthを取得し、maxから引くことでimage_input_btnのwidthを決定
      var prevContent = $('.image_input_btn').prev();
      labelWidth = (640 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.image_input_btn').css('width', labelWidth);
    }

    // file_fieldのnameに動的なindexをつける為の配列
    let fileIndex = [1,2,3,4,5,6,7,8,9,10];
    // 既に使われているindexを除外
    lastIndex = $('.js-file_group:last').data('index');
    fileIndex.splice(0, lastIndex);
  
    $('.hidden-destroy').hide();
  
    $('#image-box').on('change', '.js-file', function(e) {
      const targetIndex = $(this).parent().data('index');
      // ファイルのブラウザ上でのURLを取得する
      const file = e.target.files[0];
      const blobUrl = window.URL.createObjectURL(file);
  
      // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
      if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
        img.setAttribute('src', blobUrl);
      } else {  // 新規画像追加の処理
        $('#previews').append(buildImg(targetIndex, blobUrl));
        // fileIndexの先頭の数字を使ってinputを作る
        $('#image-box').append(buildFileField(fileIndex[0]));
        fileIndex.shift();
        // 末尾の数に1足した数を追加する
        fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
        // image_input_btnのwidth操作
        setLabel();
        // image_input_btnのidとforを更新
        $('.image_input_btn').attr({id:`image_input_btn--${targetIndex+1}`, for: `product_images_attributes_${targetIndex+1}_src`});
        // 画像のプレビューが5個あったらimage_input_btnを隠す
        if (targetIndex == 4) {
          $('.image_input_btn').hide();
        }
      }
      
    });
  
    $('#image-box').on('click', '.js-remove', function() {
      const targetIndex = $(this).parent().data('index');
      // 該当indexを振られているチェックボックスを取得する
      const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
      // もしチェックボックスが存在すればチェックを入れる
      if (hiddenCheck) hiddenCheck.prop('checked', true);
  
      $(this).parent().remove();
      $(`img[data-index="${targetIndex}"]`).remove();
  
      // 画像入力欄が0個にならないようにしておく
      if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
    });
  });