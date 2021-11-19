// ページ更新でtag-it発火
$(document).on('turbolinks:load ajax:complete', function () {
  $(".tag_form").tagit({  // 指定のセレクタ( 今回は、:tag_list の text_field )に、tag-itを反映
    tagLimit:10,         // タグの最大数
    singleField: true,   // タグの一意性
    //availableTags: []  //自動補完する一覧を設定できる(※ 配列ならok)。今回は、Ajax通信でDBの値を渡す(後述)。
  });
  let tag_count = 10 - $(".tagit-choice").length    // 登録済みのタグを数える
  $(".ui-widget-content.ui-autocomplete-input").attr(
    'placeholder','あと' + tag_count + '個登録できます');
})

// タグ入力で、placeholder を変更
$(document).on("keyup", '.tagit', function() {
  let tag_count = 10 - $(".tagit-choice").length
  $(".ui-widget-content.ui-autocomplete-input").attr(
  'placeholder','あと' + tag_count + '個登録できます');

  // Ajaxで、タグ一覧を取得
  let input = $(".ui-widget-content.ui-autocomplete-input").val();  // 変数inputに、入力値を格納
  $.ajax({
    type: 'GET',
    url: 'get_tag_search',    // ルーティングで設定したurl
    data: { key: input },     // 入力値を:keyとして、コントローラーに渡す
    dataType: 'json'
  })

  .done(function(data){
    if(input.length) {
      let tag_list = [];
      data.forEach(function(tag) {
        tag_list.push(tag.name);
      });
      $(".tag_form").tagit({
        availableTags: tag_list
      });
    }
  })
});