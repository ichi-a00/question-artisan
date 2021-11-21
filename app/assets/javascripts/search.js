//インクリメンタルサーチ用jquery
$(document).on('turbolinks:load ajax:complete', function() {
  $(document).on('input', '.index_search', function(){
    // 検索ワードの取得
    const keyword = $(this).val();
    // #indexにajax通信
    $.ajax({
      type: 'GET',
      url: 'questions',
      data: {content: keyword},
      dataType: 'script'
    })
  });
});