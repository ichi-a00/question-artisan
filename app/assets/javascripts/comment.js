//コメント系jquery
$(document).on('turbolinks:load', function() {

  //デフォルトは非表示
  $("#comments").hide();

  //クリックで表示非表示を切り替える
  $('#comments-btn').on("click", function() {
    $("#comments:not(:animated)").toggle('slow', function() {
      if($(this).css('display') == 'none') {
        $("#comments-btn").text('表示');
      }else{
        $("#comments-btn").text('非表示');
      }
    });
  });

  //投稿時は表示する
  $('#create_comment').submit(function() {
    $("#comments:not(:animated)").show('slow', function() {
      $("#comments-btn").text('非表示');
    });
  });

});