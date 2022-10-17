$(function () {
  $("#income_and_payment_item_id").change(function () {
    $.get({
      url: "/income_and_payments/select_item",
      data: { item_id: $("#income_and_payment_item_id").has("option:selected").val() }
    });
  });
});
