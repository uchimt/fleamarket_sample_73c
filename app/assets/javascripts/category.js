$(document).on('turbolinks:load', ()=> {
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html =  
      `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  //子カテゴリーの表示作成
  function appendChildrenBox(insertHTML){
    var childSelectHtml =  '';
    childSelectHtml = `<div class="product-information__category--form" id= "children_form">
                         <select class="product-information__category--select_form" id="child_category">
                           <option value="" data-category="" >選択してください</option>
                           ${insertHTML}
                         </select>
                       </div>`;
    $('.product-information__category').append(childSelectHtml);
  }
  //孫カテゴリーの表示作成
  function appendGrandchildrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class="product-information__category--form" id= "grandchildren_form">
                             <select class="product-information__category--select_form" id="grandchild_category" name="product[category_id]">
                               <option value="" data-category="">選択してください</option>
                               ${insertHTML}
                             </select>
                            </div>`;
    $('.product-information__category').append(grandchildSelectHtml);
  }
  //親カテゴリー選択後のイベント
  $('#parent_category').on('change', function(){
    var parentCateogry = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
    if (parentCateogry != "") { //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: 'get_category_children',
        type: 'GET',
        data: { parent_name: parentCateogry },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_form').remove(); //親が変更された時、子以下を削除する
        $('#grandchildren_form').remove(); 
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_form').remove(); //親が変更された時、子以下を削除する
      $('#grandchildren_form').remove(); 
    } 
  });
  //子カテゴリー選択ごのイベント
  $('.product-information__category').on('change','#child_category', function(){
    var childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
    if (childId != "") { //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren) {
        if (grandchildren.length != 0) {
          $('#grandchildren_form').remove(); //親が変更された時、孫以下を削除する
          var insertHTML ='';
          grandchildren.forEach(function(grandchild) {
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function() {
        alert('カテゴリーの取得に失敗しました');
      })
    }else {
      $('#grandchildren_form').remove(); 
    }
  });
});