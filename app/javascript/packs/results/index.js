$(function () {
  $(".item-names").on('click', function () {
    var item_id = $(this).prop('id');
    if ($(this).hasClass("opened-item")) {
      $(`#detai-item-${item_id}`).remove();
      $(`#detai-item-value-${item_id}`).remove();
      $(this).removeClass("opened-item");
      $(this).children(".open-toggle-button").text("+");
    } else {
      $(this).addClass("opened-item");
      $.get({
        url: `/results/${item_id}/open_item`,
      });
      $(this).children(".open-toggle-button").text("-");
    }
  });
});