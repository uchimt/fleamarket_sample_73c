$(document).on('turbolinks:load', function() {
  $(function() {
    $('#brand-search-field').on('keyup', function() {
      var input = $('brand-search-field').value
      $.ajax({
        type: 'GET',
        url: '/brands',
        dataType: 'json',
        data: { keyword: input }
      })
      .done(function() {
        console.log("成功です");
      })
      .fail(function() {
        console.log("失敗です");
      });
    });
  });
});