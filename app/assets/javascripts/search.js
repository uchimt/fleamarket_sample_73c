$(document).on('change','select.price-range',function() {
  var value = $('select.price-range').val();
  switch(value) {
    case 'none':
        console.log('選択してください');
        $(".price-range__min").val("");
        $(".price-range__max").val("");
        break;
    case 'price1':
        console.log('¥300〜¥1,000');
        $(".price-range__min").val("300");
        $(".price-range__max").val("1000");
        break;
    case 'price2':
        console.log('¥1,000〜¥5,000');
        $(".price-range__min").val("1000");
        $(".price-range__max").val("5000");
        break;
    case 'price3':
        console.log('¥5,000〜¥10,000');
        $(".price-range__min").val("5000");
        $(".price-range__max").val("10000");
        break;
    case 'price4':
        console.log('¥10,000〜¥30,000');
        $(".price-range__min").val("10000");
        $(".price-range__max").val("30000");
        break;
    case 'price5':
        console.log('¥30,000〜¥50,000');
        $(".price-range__min").val("30000");
        $(".price-range__max").val("50000");
        break;
    case 'price6':
        console.log('¥50,000〜¥100,000');
        $(".price-range__min").val("50000");
        $(".price-range__max").val("100000");
        break;
  }
})
