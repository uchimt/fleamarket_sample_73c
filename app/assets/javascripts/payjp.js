$(function(){
  Payjp.setPublicKey('pk_test_5024afd1b47d305ec8a6f602');


  let form = $('.form');
  $("#charge-form").click(function(){
    form.find("input[type=submit]").prop("disabled", true);//submitボタンを無効にした

  

  //formで入力されたカード情報を取得
  let card = {
    number: $("#card_number").val(),
    cvc: $("#cvc").val(),
    exp_month: $("#exp_month").val(),
    exp_year: $("#exp_year").val()
  };

  //PAY.JPに登録するためのトークン作成
  Payjp.createToken(card,function(status, response){
    if (response.error){
      // エラーがある場合処理しない。
      form.find('.payment-errors').text(response.error.message);
      form.find('button').prop('disabled', false);
    }   
    
      if (status === 200) { //成功した場合(status === 200はリクエストが成功している状況です。)
        //データを自サーバにpostしないようにremoveAttr("name")で削除
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name"); 
        $("#charge-form").append(
          $('<input type="hidden" name="payjp_token">').val(response.id)
        ); //取得したトークンを送信できる状態にします
        document.inputForm.submit();
        alert("登録が完了しました"); //正常処理完了確認用。createビューがあればつけなくてもOKかな
      } 
   
    });
  });
});
