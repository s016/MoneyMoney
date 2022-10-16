$(function () {
  $("#income_and_payment_item_id").change(function () {
    console.log("change_id");
    $.get({
      url: "#{item_detail_items_path}",
      data: { item_id: $("item_id").has("option:selected").val() }
    });
  });
});
