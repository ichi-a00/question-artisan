$(document).on('turbolinks:load ajax:complete', function() {
  $('#del-btn').on('click',function()
  {
    $(this).parent('form').find(':text').val("");
    $('.index_search').trigger('input');
  });
});